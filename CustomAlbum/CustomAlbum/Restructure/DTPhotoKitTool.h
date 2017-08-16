//
//  DTPhotoKitTool.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "PHAsset+DT.h"
#import "DTPhotosGrounpModel.h"
#import "DTPhotoModel.h"
#import "QMFileManager.h"

// block tupe 1 是 视频 0是图片  url 替换完成的url地址
typedef void(^infoBlock)(int type,NSString *url ,NSString *local ,NSError *error);

@interface DTPhotoKitTool : NSObject

// 用户授权  回调回去用户状态
+ (void)userAuthorization:(void(^)(PHAuthorizationStatus status))block;

// 遍历所有组 2:1  stop 停止遍历
+ (void)fetchAllGround:(void(^)(NSMutableArray <DTPhotosGrounpModel *>*grounds))block stop:(BOOL *)stop;

// 获取缩略图返回image
+ (void)reqeustImage:(PHAsset *)asset block:(void(^)(UIImage *image))block;

// 通过PHAsset 请求原数据 返回地址
+ (void)reqeust0riginalData:(PHAsset *)asset block:(infoBlock)block;

// 清空缓存
+ (void)clearDiskCache;

@end
