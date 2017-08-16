//
//  DTPhotosCollectionCellModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "DTPhotoModel.h"
#import "DTLocalPhotoModel.h"
#import "DTPhotoCloudModel.h"

@interface DTPhotosCollectionCellModel : NSObject

// 选中状态
@property (nonatomic, assign) BOOL isSelect;

// 数据来源
@property (nonatomic, assign) int sourceType;

// 手机相册数据
@property (nonatomic, strong) DTPhotoModel *phonephotoModel;

// 沙盒数据
@property (nonatomic, strong) DTLocalPhotoModel *localModel;

// 云端数据
@property (nonatomic, strong) DTPhotoCloudModel *cloudModel;


///*
// 文件名字
// */
//@property (nonatomic, copy) NSString *fileName;
//
///*
// 沙盒文件缩略图地址
// */
//@property (nonatomic, copy) NSString *localThumbDataFilePath;
//
///*
// 沙盒文件地址
// */
//@property (nonatomic, copy) NSString *localOriginalDataFilePath;
///*
// 去系统相册资源对象
// */
//@property (nonatomic, strong) PHAsset *asset;


@end
