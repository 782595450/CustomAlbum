//
//  DTPhotosGrounpModel.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosGrounpModel.h"

@implementation DTPhotosGrounpModel

- (instancetype)init{
    if (self = [super init]) {
        _phonephotoArr = [[NSMutableArray alloc] init];
        _sandboxphotoArr = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
