//
//  DTLocalPhotoModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DTLocalPhotoModel : NSObject

/*
 文件名字
 */
@property (nonatomic, copy) NSString *fileName;

/*
 沙盒文件缩略图地址
 */
@property (nonatomic, copy) NSString *localThumbDataFilePath;

/*
 沙盒文件地址
 */
@property (nonatomic, copy) NSString *localOriginalDataFilePath;

/*
 缩略图 用于归档，PHAsset不能归档
 */
@property (nonatomic, strong) UIImage *thumbImage;


@end
