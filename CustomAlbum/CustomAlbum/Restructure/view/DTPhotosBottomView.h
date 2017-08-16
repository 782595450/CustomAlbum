//
//  DTPhotosBottomView.h
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^bottomDidClick)();
@interface DTPhotosBottomView : UIView

@property (nonatomic, assign) int sourceType;                // 数据来源

@property (nonatomic, assign) int selectCount;

@property (nonatomic, copy) bottomDidClick shareBlock;
@property (nonatomic, copy) bottomDidClick downloadBlock;
@property (nonatomic, copy) bottomDidClick deleteBlock;
@property (nonatomic, copy) bottomDidClick cloudBlock;

@end
