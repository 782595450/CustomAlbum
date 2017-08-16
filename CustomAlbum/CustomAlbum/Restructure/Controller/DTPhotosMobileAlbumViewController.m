//
//  DTPhotosMobileAlbumViewController.m
//  PhotosTest
//
//  Created by lsq on 2017/8/15.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosMobileAlbumViewController.h"
#import "DTPhotoKitTool.h"

@interface DTPhotosMobileAlbumViewController ()

@end

@implementation DTPhotosMobileAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weak = self;
    self.selectBtnBlock = ^(BOOL select) {
        __strong typeof(weak) self = weak;
        self.isSelect = select;
    };
    
    self.cellDidClick = ^(DTPhotosCollectionCellModel *cellModel) {
        __strong typeof(weak) self = weak;
        [self cellContainerViewDidClick:cellModel];
    };
}


#pragma mark - cell 点击事件
-(void)cellContainerViewDidClick:(DTPhotosCollectionCellModel *)cellModel{
    __weak typeof(self) weak = self;
    void (^block)(int type,NSString *url ,NSString *loacl ,NSError *error) = ^(int type,NSString *url ,NSString *loacl, NSError *error){
        __strong typeof(weak) self = weak;
        if (!error) {  //3 p  6 v 7 m 8 z
            NSString *stype = type ? @"6":@"3";
            NSDictionary *json = @{
                                   @"action":@"PlayViewController",
                                   @"playType":@"UIPlayTypelocal",
                                   @"URL" :url,
                                   @"picMode":stype,
                                   @"DTShareFrom" :@"DTShareFrom_Local",
                                   @"DTPhotosCollectionCellModel" :cellModel,
                                   @"playSourceListArr" :self.photos
                                   };
            NSLog(@"json:%@",json);
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }else {
        }
    };
    if (cellModel.phonephotoModel) {
        [DTPhotoKitTool reqeust0riginalData:cellModel.phonephotoModel.asset block:block];
    } else {
        DTLocalPhotoModel *localModel = cellModel.localModel;
        NSURL *url = [NSURL fileURLWithPath:localModel.localOriginalDataFilePath];
        BOOL isv = YES;
        if (([localModel.localThumbDataFilePath.lowercaseString rangeOfString:@"jpg"].location != NSNotFound) || [localModel.localThumbDataFilePath.lowercaseString rangeOfString:@"png"].location != NSNotFound) {
            isv = NO;
        }
        block(isv,url.absoluteString,nil,nil);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
