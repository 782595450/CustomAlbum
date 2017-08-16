//
//  DTPhotosCollectionViewCell.h
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTPhotosCollectionBaseViewController.h"
#import "DTPhotosCollectionCellModel.h"
#import "DTPhotosPhoneContainerView.h"

//@protocol QMCellDelegate <NSObject>
//@optional

//// cell 点击事件
//- (void)cellContainerViewDidClick:(id)cell;
//
////选择按钮的点击事件
//- (void)cellContainerViewChooseClick:(id)cell;
//
////上传完毕调用
//- (void)cellUploadContainerViewComplection:(id)cell;
//
////上传失败调用
//- (void)cellUploadContainerViewFailure:(id)cell;
//@end

@interface DTPhotosCollectionViewCell : UICollectionViewCell
//@property (strong , nonatomic)  QMCellContainerView *photosContainerView; //容器
//@property (strong , nonatomic)  QMPhotosLayout *photoslayout; //布局
///*
// 传进来的Cell  用来处理点击事件回调
// */
//@property (weak , nonatomic) id <QMCellDelegate>delegate;
@property (nonatomic, assign) int sourceType;                // 数据来源
@property (nonatomic, strong) DTPhotosCollectionCellModel *cellModel;
@property (nonatomic, assign, setter=setisSelect:) BOOL isSelect;

@end
