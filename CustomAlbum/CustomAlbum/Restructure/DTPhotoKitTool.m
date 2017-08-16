//
//  DTPhotoKitTool.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotoKitTool.h"
#import "YYMemoryCache.h"
#import "YYDiskCache.h"

#define CGPixel  CGSizeMake(64*3,64*3)              // 缩略图大小

@implementation DTPhotoKitTool

#pragma mark - 授权
+ (void)userAuthorization:(void (^)(PHAuthorizationStatus))block{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (block) {
            block(status);
        }
    }];
}

#pragma mark - ground
+ (void)fetchAllGround:(void (^)(NSMutableArray<DTPhotosGrounpModel *> *))block stop:(BOOL *)stop{

    dispatch_group_t group = dispatch_group_create();
    __block NSMutableArray *smartAlbums = [NSMutableArray new];
    // 获取系统的相薄
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self fetchAlbumType:PHAssetCollectionTypeSmartAlbum block:^(NSMutableArray<DTPhotosGrounpModel *> *grounpModel) {
            smartAlbums = grounpModel;
        } stop:stop];
    });
    
    // 获取自定义的相薄
    __block  NSMutableArray *typeAlbums = [NSMutableArray new];
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchAlbumType:PHAssetCollectionTypeAlbum block:^(NSMutableArray<DTPhotosGrounpModel *> *grounpModel) {
            typeAlbums = grounpModel;
        } stop:stop];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *alls = [NSMutableArray new];
        [alls addObjectsFromArray:smartAlbums];
        [alls addObjectsFromArray:typeAlbums];
        if (block) {
            block(alls);
        }
    });

}


#pragma mark -  相薄
+ (void)fetchAlbumType:(PHAssetCollectionType)type block:(void (^)(NSMutableArray<DTPhotosGrounpModel *> *))block stop:(BOOL *)stop{
    if (block == nil){
        return;
    }
    // 保存所有相薄
    NSMutableArray *photoGrounpArr = [[NSMutableArray alloc] init];
    
    PHFetchResult<PHAssetCollection *> *results = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    @autoreleasepool {
        for (PHAssetCollection *album in results) {
            if (*stop){
                NSLog(@"super stop");
                break;
            }
            if (!album.estimatedAssetCount) {
                continue;
            }
            NSLog(@"%@",album.localizedTitle);
            PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:album options:nil];
           
            // 单个相薄的文件
            DTPhotosGrounpModel *grounpModel = [[DTPhotosGrounpModel alloc] init];
            grounpModel.context = album.localizedTitle;
            for (PHAsset *asset in assetResult) {
                if (*stop){
                    NSLog(@"sub stop");
                    break;
                }
                if (asset.mediaType == PHAssetMediaTypeAudio) continue;
                if (asset.isFileProportionTwotoOne) {
                    DTPhotoModel *assetModel = [DTPhotoModel new];
                    PHAssetResource *resource = [PHAssetResource assetResourcesForAsset:asset].firstObject;
                    assetModel.fileName = resource.originalFilename;
                    assetModel.asset = asset;
                    [grounpModel.phonephotoArr addObject:assetModel];
                }
            }
            
            if (!grounpModel.phonephotoArr.count){
                continue;
            }
            
            //  时间排序
            grounpModel.phonephotoArr = [DTPhotoKitTool sortList:grounpModel.phonephotoArr];
            [photoGrounpArr addObject:grounpModel];
        }

        // 传出回调
        if (block) {
            block(photoGrounpArr);
        }

    }
}

#pragma mark - 列表按时间排序
+ (NSMutableArray*)sortList:(NSMutableArray*)arr{
    NSMutableArray *sortDescriptors  = [NSMutableArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"asset.creationDate" ascending:NO]];
    arr = [NSMutableArray arrayWithArray:[arr sortedArrayUsingDescriptors: sortDescriptors]];
    return arr;
}

#pragma mark 请求原数据
+ (void)reqeust0riginalData:(PHAsset *)asset block:(infoBlock)block{
    @autoreleasepool {
        PHAssetResource *resource = [PHAssetResource assetResourcesForAsset:asset].firstObject;
        NSString *key = resource.originalFilename;
        BOOL isMediaType = 0;
        if (asset.mediaType == PHAssetMediaTypeVideo) {
            isMediaType = 1;
        }
        NSString *path = [[QMFileManager fileManger] pathFromFileName:key];
        NSURL *url = [[QMFileManager fileManger]urlFromFileName:key];
        NSString *local = url.absoluteString;
        if ([[QMFileManager fileManger]fileExistsAtPath:path]) {
            if (block) {
                block(isMediaType,local,path,nil);
            }
            return;
        }
        [[PHAssetResourceManager defaultManager] writeDataForAssetResource:resource toFile:url options:nil completionHandler:^(NSError * _Nullable error) {
            if (block) {
                block(isMediaType,local ,path, error);
            }
        }];
    }
}

+ (YYDiskCache *)memory{
    static YYDiskCache *memory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        memory = [[YYDiskCache alloc] initWithPath:path];
    });
    return memory;
}

+ (void)clearDiskCache{
    [[self memory] removeAllObjects];
}

#pragma mark - 获取相册文件的缩略图
+ (void)reqeustImage:(PHAsset *)asset block:(void (^)(UIImage *))block{
    @autoreleasepool {
        if (!block)return;
        id imageData = [[self memory] objectForKey:asset.description];
        if (imageData) {
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            if (block) {
                block(image);
            }
            return;
        }
        static dispatch_queue_t queue = nil;
        static dispatch_once_t onceToken1;
        dispatch_once(&onceToken1, ^{
            queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
        });
        dispatch_async(queue, ^{
            
            static PHImageRequestOptions *options = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                options = [[PHImageRequestOptions alloc] init];
                options.synchronous = YES;
                options.resizeMode = PHImageRequestOptionsResizeModeFast;
            });
            
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGPixel contentMode:
             PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (result) {
                         block(result);
                     }
                 });
                 dispatch_async(queue, ^{
                     @autoreleasepool {
                         NSData *data = UIImageJPEGRepresentation(result, 1.0);
                         [[self memory] setObject:data forKey:asset.description];
                     }
                 });
             }];
            
        });
    }
}

@end
