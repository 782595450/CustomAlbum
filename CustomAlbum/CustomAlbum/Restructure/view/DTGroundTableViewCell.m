//
//  DTGroundTableViewCell.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTGroundTableViewCell.h"
#import "Masonry.h"
#import "DTPhotoKitTool.h"

@interface DTGroundTableViewCell()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DTGroundTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectedBackgroundView = nil;
    
    [self initUI];
    
    return self;
}

- (void)initUI{
    __weak typeof(self) weak = self;
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(- 0.5));
        make.height.equalTo(@0.5);
    }];
    
    UIImageView *thumbImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:thumbImageView];
    self.thumbImageView = thumbImageView;
    [thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@5);
        make.bottom.equalTo(@-5);
        make.width.equalTo(@90);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    titleLabel.text = nil;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weak) self = weak;
        make.left.equalTo(self.thumbImageView.mas_right).offset(15);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@-40);
    }];
    self.titleLabel = titleLabel;


}
- (void)refreshUI{
    self.titleLabel.text = self.grounpModel.context;
    //手机相册组列表 这里还需要处理一下得图APP内的图片显示这个是默认显示的
    if (self.grounpModel.phonephotoArr.count > 0) {
        DTPhotoModel *photoModel = self.grounpModel.phonephotoArr.firstObject;
        
        [self _thumbnailViewAsset:photoModel.asset block:^(UIImage *thumbImage) {
            self.thumbImageView.image = thumbImage;
        }];
    } else if (self.grounpModel.sandboxphotoArr.count > 0){
        DTLocalPhotoModel *localModel = self.grounpModel.sandboxphotoArr.firstObject;
        UIImage *image = [UIImage imageWithContentsOfFile:localModel.localThumbDataFilePath];
        self.thumbImageView.image = [self getImageLeft:image];
    } else {
        self.thumbImageView.image = [UIImage imageNamed:@"相册默认图"];
    }

    NSLog(@"---%@",self.grounpModel.context);
    
}

//加载系统相册的的图片
-(void)_thumbnailViewAsset:(PHAsset *)asset block:(void (^)(UIImage *))block{
    __weak typeof(self) weak = self;
    [DTPhotoKitTool reqeustImage:asset block:^(UIImage *image) {
        __strong typeof(weak) self = weak;
        UIImage *leftImage =  [self getImageLeft:image];
        if (block) {
            block(leftImage);
        }
    }];
}


- (UIImage *)getImageLeft:(UIImage *)image{
    UIImage *_image = nil;
    CGImageRef newImage = nil;
    @autoreleasepool {
        newImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width / 2, image.size.height));
        _image  = [UIImage imageWithCGImage:newImage];
    }
    CFRelease(newImage);
    return _image;

}

- (void)setGrounpModel:(DTPhotosGrounpModel *)grounpModel{
    _grounpModel = grounpModel;
    [self refreshUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
