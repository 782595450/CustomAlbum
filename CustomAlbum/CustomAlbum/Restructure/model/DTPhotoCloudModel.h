//
//  DTPhotoCloudModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTPhotoCloudModel : NSObject
-(instancetype)initWithDict:(id)dict;
@property (copy ,  nonatomic) NSString *thumburl;    //缩略图
@property (copy ,  nonatomic) NSString *app_config;  //播放地址
@property (copy ,  nonatomic) NSString *uploadtime; //时间
@property (copy ,  nonatomic) NSString *imagedes;  //描述
@property (copy ,  nonatomic) NSString *name;       // 名字
@property (copy ,  nonatomic) NSString *picmode;  //3 是图片 6是视频
@property (strong ,nonatomic) NSString *ID;
@property (copy ,  nonatomic) NSString *nikeName;
@property (copy ,  nonatomic) NSString *default_quality;
@property (copy ,  nonatomic) NSString *max_quality;
@property (assign , nonatomic)BOOL  iscanview; //是否是私有的    1公开  0私有可见

@end
