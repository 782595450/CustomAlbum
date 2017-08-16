//
//  DTGroundTableViewCell.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTPhotosGrounpModel.h"

@interface DTGroundTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) DTPhotosGrounpModel *grounpModel;

@end
