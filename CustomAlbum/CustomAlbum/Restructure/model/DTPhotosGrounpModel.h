//
//  DTPhotosGrounpModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPhotoModel.h"
#import "DTLocalPhotoModel.h"

@interface DTPhotosGrounpModel : NSObject

/*
    相册名
 */
@property (nonatomic, copy) NSString *context;

/*
    手机相册文件集合
 */
@property (nonatomic, strong) NSMutableArray<DTPhotoModel *> *phonephotoArr;

/*
    沙盒文件集合
 */
@property (nonatomic, strong) NSMutableArray<DTLocalPhotoModel *> *sandboxphotoArr;



@end

