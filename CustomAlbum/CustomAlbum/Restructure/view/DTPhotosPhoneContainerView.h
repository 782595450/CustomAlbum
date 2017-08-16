//
//  DTPhotosPhoneContainerView.h
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTPhotosCollectionCellModel.h"

@interface DTPhotosPhoneContainerView : UIView

@property (nonatomic, strong) DTPhotosCollectionCellModel *cellModel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end
