//
//  DTPhotosCollectionViewCell.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosCollectionViewCell.h"

@interface DTPhotosCollectionViewCell()

@property (nonatomic, strong) DTPhotosPhoneContainerView *containerView;

@end

@implementation DTPhotosCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = nil;
    
    return self;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[DTPhotosPhoneContainerView alloc] init];
        _containerView.frame = CGRectMake(0, 0, 196, 121);
        [self addSubview:_containerView];
    }
    return _containerView;

}

- (void)setCellModel:(DTPhotosCollectionCellModel *)cellModel{
    _cellModel = cellModel;
    switch (cellModel.sourceType) {
        case DTPhotosCellSourceType_Camera:
            //  相机相册的容器
            break;
        case DTPhotosCellSourceType_Phone:
            //  手机相册的容器
            [self containerView];
            self.containerView.cellModel = _cellModel;
            break;
        case DTPhotosCellSourceType_Cloud:
            //  云端相册的容器
            break;
        case DTPhotosCellSourceType_Upload:
            //  上传列表的容器
            break;
 
        default:
            break;
    }
    
}

- (void)setisSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    switch (_cellModel.sourceType) {
        case DTPhotosCellSourceType_Camera:
            break;
        case DTPhotosCellSourceType_Phone:
            [self containerView];
            self.containerView.selectImageView.hidden = !isSelect;
            break;
        case DTPhotosCellSourceType_Upload:
            break;
        default:
            break;
    }
}

@end
