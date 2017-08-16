//
//  DTPhotosBaseViewController.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTPhotosBaseViewController : UIViewController

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, assign ,setter=setHiddeSelectBtn:) BOOL hiddeSelectBtn;
@property (nonatomic, copy) void(^selectBtnBlock)(BOOL);
/*
 返回按钮
 */
@property (copy , nonatomic) void(^backblock)();

@end
