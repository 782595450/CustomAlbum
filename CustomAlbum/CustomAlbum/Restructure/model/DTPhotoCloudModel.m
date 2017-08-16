//
//  DTPhotoCloudModel.m
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotoCloudModel.h"

@implementation DTPhotoCloudModel
-(instancetype)initWithDict:(id)dict{
    if (self=[super init]) {
        _picmode = dict[@"picmode"];
        _default_quality = dict[@"default_quality"];
        _max_quality     = dict[@"max_quality"];
        _nikeName =  dict[@"author"][@"nickname"];
        _thumburl  = dict[@"thumburl"];
        _app_config  = dict[@"app_config"];
        _ID = dict[@"id"];
        _name =  dict[@"name"];
        _imagedes = dict[@"imagedes"];
        _iscanview = [dict[@"iscanview"] intValue];
        
    }
    return self;
}

@end
