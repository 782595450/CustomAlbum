//
//  DTPhotosBottomView.m
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosBottomView.h"
#import "DTPhotosCollectionBaseViewController.h"
#import "Masonry.h"

@interface DTPhotosBottomView()

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *cloudBtn;

@end

@implementation DTPhotosBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
    
}

- (void)delete{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shareBtn];

    }
    return _shareBtn;
    
}

- (void)share{
    if (self.shareBlock) {
        self.shareBlock();
    }
}

- (UIButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [[UIButton alloc] init];
        [_downloadBtn setImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_downloadBtn];

    }
    return _downloadBtn;
    
}

- (void)download{
    if (self.downloadBlock) {
        self.downloadBlock();
    }
}

- (UIButton *)cloudBtn{
    if (!_cloudBtn) {
        _cloudBtn = [[UIButton alloc] init];
        [_cloudBtn setImage:[UIImage imageNamed:@"云端"] forState:UIControlStateNormal];
        [_cloudBtn addTarget:self action:@selector(cloud) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cloudBtn];
    }
    return _cloudBtn;
    
}

- (void)cloud{
    if (self.cloudBlock) {
        self.cloudBlock();
    }
}

- (instancetype)init{
    if (self == [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setSourceType:(int)sourceType{
    _sourceType = sourceType;
}

- (void)setSelectCount:(int)selectCount{
    _selectCount = selectCount;
    switch (_sourceType) {
        case DTPhotosCellSourceType_Camera:{
                //  相机相册
                if (selectCount == 1) {
                    self.downloadBtn.hidden = NO;
                    self.shareBtn.hidden = NO;
                    self.deleteBtn.hidden = NO;
                    
                    self.downloadBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0-24-87, 12, 24, 20);
                    self.shareBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
                    self.deleteBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0+87, 12, 24, 20);

                }else if (selectCount > 1){
                    self.downloadBtn.hidden = YES;
                    self.shareBtn.hidden = YES;
                    self.deleteBtn.hidden = NO;
                    self.deleteBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
                }
            }
            break;
        case DTPhotosCellSourceType_Phone:
            //  手机相册
            if (selectCount == 1) {
                self.cloudBtn.hidden = NO;
                self.shareBtn.hidden = NO;
                self.cloudBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0-24-87, 12, 24, 20);
                self.shareBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
            }else if (selectCount > 1){
                self.shareBtn.hidden = YES;
                self.cloudBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
            }

            break;
            
        case DTPhotosCellSourceType_Local:
            //  沙盒文件
            if (selectCount == 1) {
                self.cloudBtn.hidden = NO;
                self.shareBtn.hidden = NO;
                self.deleteBtn.hidden = NO;
                self.cloudBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0-24-87, 12, 24, 20);
                self.shareBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
                self.deleteBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0+87, 12, 24, 20);
            }else if (selectCount > 1){
                self.shareBtn.hidden = YES;
                self.cloudBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0, 12, 24, 20);
                self.deleteBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-24)/2.0+87, 12, 24, 20);

            }
            
            break;
            
        default:
            break;
    }
}

@end
