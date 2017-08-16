//
//  DTPhotosPhoneContainerView.m
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosPhoneContainerView.h"
#import "DTPhotoKitTool.h"
#import "Masonry.h"

@interface DTPhotosPhoneContainerView()

@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *fileTypeImageView;

@end

@implementation DTPhotosPhoneContainerView

- (instancetype)init{
    if (self == [super init]) {
        [self initUI];
    }
    return self;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.frame = CGRectMake(0, 0, 192, 87.5 + 10);
        [self addSubview:_thumbImageView];
    }
    return _thumbImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.frame = CGRectMake(0, 87.5 + 10, 192, 33.5);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.frame = CGRectMake(192-4-21, 4, 21, 21);
        _selectImageView.image = [UIImage imageNamed:@"选择-空"];
        [self addSubview:_selectImageView];
        
    }
    return _selectImageView;
}

- (UIImageView *)fileTypeImageView{
    if (!_fileTypeImageView) {
        _fileTypeImageView = [[UIImageView alloc] init];
        _fileTypeImageView.frame = CGRectMake(0, 87.5 + 10 - 17.5, 20, 17.5);
        [self addSubview:_fileTypeImageView];
    }
    return _fileTypeImageView;
}

- (void)initUI{
    [self thumbImageView];
    [self titleLabel];
    [self selectImageView];
    [self fileTypeImageView];
}

- (void)setCellModel:(DTPhotosCollectionCellModel *)cellModel{
    _cellModel = cellModel;
    if (cellModel.phonephotoModel) {
        DTPhotoModel *phonephotoModel = cellModel.phonephotoModel;
        [self _thumbnailViewAsset:phonephotoModel.asset block:^(UIImage *image) {
            self.thumbImageView.image  = image;
        }];
        if (phonephotoModel.asset.mediaType == PHAssetMediaTypeImage) {
            self.fileTypeImageView.image = [UIImage imageNamed:@"图片"];
        }else{
            self.fileTypeImageView.image = [UIImage imageNamed:@"视频"];
        }
        self.titleLabel.text = phonephotoModel.fileName;

    }else{
        DTLocalPhotoModel *localModel = cellModel.localModel;
        self.thumbImageView.image = [UIImage imageWithContentsOfFile:localModel.localThumbDataFilePath];
        if (([localModel.localThumbDataFilePath.lowercaseString rangeOfString:@"jpg"].location != NSNotFound) || [localModel.localThumbDataFilePath.lowercaseString rangeOfString:@"png"].location != NSNotFound) {
            self.fileTypeImageView.image = [UIImage imageNamed:@"图片"];
        }else{
            self.fileTypeImageView.image = [UIImage imageNamed:@"视频"];
        }
        self.titleLabel.text = localModel.fileName;

    }
    
    if (cellModel.isSelect) {
        _selectImageView.image = [UIImage imageNamed:@"选中状态"];
    }else{
        _selectImageView.image = [UIImage imageNamed:@"选择-空"];
    }
    
}

//加载系统相册的的图片
-(void)_thumbnailViewAsset:(PHAsset *)asset block:(void (^)(UIImage *))block{
    [DTPhotoKitTool reqeustImage:asset block:^(UIImage *image) {
        if (block) {
            block(image);
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
