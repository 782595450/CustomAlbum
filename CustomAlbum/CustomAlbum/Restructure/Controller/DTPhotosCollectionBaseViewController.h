//
//  DTPhotosCollectionBaseViewController.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTPhotosBaseViewController.h"
#import "DTPhotosCollectionViewCell.h"
#import "DTPhotosCollectionCellModel.h"
#import "DTPhotosBottomView.h"

// 数据来源
typedef NS_ENUM(NSUInteger , DTPhotosCellSourceType){
    DTPhotosCellSourceType_None,                    ///<<没有类型
    DTPhotosCellSourceType_Camera,                  ///<<相机相册
    DTPhotosCellSourceType_Phone,                   ///<<手机相册
    DTPhotosCellSourceType_Cloud,                   ///<<云端相册
    DTPhotosCellSourceType_Upload,                  ///上传列表
    DTPhotosCellSourceType_Local                    ///沙盒

};

@interface DTPhotosCollectionBaseViewController : DTPhotosBaseViewController

//给子类调用的
@property (nonatomic, weak) UICollectionView *photosCollectionView;
@property (nonatomic, strong) NSMutableArray<DTPhotosCollectionCellModel *> *selecteds;                     // 选中
@property (nonatomic, strong) NSMutableArray<DTPhotosCollectionCellModel *> *photos;                        // 传入数据
@property (nonatomic, assign, setter=setisSelect:) BOOL isSelect;

@property (nonatomic, copy) void(^cellDidClick)(DTPhotosCollectionCellModel *);
@property (nonatomic, copy) bottomDidClick shareBlock;
@property (nonatomic, copy) bottomDidClick downloadBlock;
@property (nonatomic, copy) bottomDidClick deleteBlock;
@property (nonatomic, copy) bottomDidClick cloudBlock;


@end
