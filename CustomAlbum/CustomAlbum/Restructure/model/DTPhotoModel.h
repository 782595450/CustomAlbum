//
//  DTPhotoModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface DTPhotoModel : NSObject
/*
 文件名字
 */
@property (nonatomic, copy) NSString *fileName;
/*
 去系统相册资源对象
 */
@property (nonatomic, strong) PHAsset *asset;
/*
 缩略图 用于归档，PHAsset不能归档
 */
@property (nonatomic, strong) UIImage *thumbImage;

@end
