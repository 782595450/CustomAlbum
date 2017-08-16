//
//  DTPhotosGrounpViewController.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosGrounpViewController.h"
#import "Masonry.h"
#import "DTPhotoKitTool.h"
#import "DTGroundTableViewCell.h"
#import "DTPhotosMobileAlbumViewController.h"
#import "DTPhotosCollectionCellModel.h"

#define MMScreenH [UIScreen mainScreen].bounds.size.height
#define MMIphone6H 667.000000
//组列表Cell的高度
#define QMGroundCellHeight 100 / MMIphone6H * MMScreenH

@interface DTPhotosGrounpViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *groundTableView;
@property (nonatomic, strong) NSMutableArray *grounds;
@property (nonatomic, assign) BOOL isFetch;                             //  是否停止遍历

@end

@implementation DTPhotosGrounpViewController

- (void)dealloc{
    NSLog(@"DTPhotosGrounpViewController dealloc");
}

- (UITableView *)groundTableView{
    if (!_groundTableView) {
        UITableView *groundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height -  64) style:UITableViewStylePlain];
        groundTableView.delaysContentTouches = NO;
        groundTableView.canCancelContentTouches = YES;
        groundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        groundTableView.rowHeight = QMGroundCellHeight;
        groundTableView.dataSource = self;
        groundTableView.delegate   = self;
        [self.view addSubview:groundTableView];
        _groundTableView  = groundTableView;
    }
    return _groundTableView;
}

- (NSMutableArray *)grounds{
    if (!_grounds) {
        _grounds = [[NSMutableArray alloc] init];
    }
    return _grounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载相册资源
    [self loadPhotoData];
    
}

- (instancetype)init{
    if (self == [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.titleText = @"手机相册";
        self.hiddeSelectBtn = YES;

    }
    return self;
}

#pragma mark - 加载相册数据
- (void)loadPhotoData{
    __strong typeof(self) weak = self;
    [DTPhotoKitTool userAuthorization:^(PHAuthorizationStatus status) {
        __strong typeof(weak) self = weak;
        __weak typeof(self) weak = self;
        // 判断是否授权
        if (status == PHAuthorizationStatusAuthorized) {
            // 获取相册数据
            [DTPhotoKitTool fetchAllGround:^(NSMutableArray<DTPhotosGrounpModel *> *grounds) {
                __strong typeof(weak) self = weak;
                if (self) {
                    [self.grounds addObjectsFromArray:grounds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.groundTableView reloadData];
                    });
                    
                }
            }stop:&_isFetch];
        }else {
            // 没有授权，提示
//            [self _userAuthorizationHUD];
        }
    }];
}


#pragma mark - 沙盒里的文件按修改日期排序
- (NSArray *)filesByModDate: (NSString *)fullPath{
    NSError* error = nil;
    NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullPath
                                                                         error:&error];
    if(error == nil){
        NSMutableDictionary* filesAndProperties = [NSMutableDictionary	dictionaryWithCapacity:[files count]];
        for(NSString* path in files){
            NSDictionary* properties = [[NSFileManager defaultManager]
                                        attributesOfItemAtPath:[fullPath stringByAppendingPathComponent:path]
                                        error:&error];
            NSDate* modDate = [properties objectForKey:NSFileModificationDate];
            
            if(error == nil){
                [filesAndProperties setValue:modDate forKey:path];
            }
        }
        return [filesAndProperties keysSortedByValueUsingSelector:@selector(compare:)];
    }
    return nil;
}

#pragma mark  - tableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.grounds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTGroundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groundTabelCell"];
    if (!cell) {
        cell = [[DTGroundTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"groundTabelCell"];
    }
    cell.grounpModel  = self.grounds[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DTPhotosGrounpModel *grounpModel  = self.grounds[indexPath.row];

    NSMutableArray *cellArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < grounpModel.phonephotoArr.count; i ++) {
        DTPhotosCollectionCellModel *cellModel = [[DTPhotosCollectionCellModel alloc] init];
        DTPhotoModel *photoModel = [grounpModel.phonephotoArr objectAtIndex:i];
        cellModel.isSelect = NO;
        cellModel.phonephotoModel = photoModel;
        cellModel.sourceType = DTPhotosCellSourceType_Phone;
        [cellArr addObject:cellModel];
    }
    
    DTPhotosMobileAlbumViewController *mobileAlbumVC = [[DTPhotosMobileAlbumViewController alloc] init];
    mobileAlbumVC.titleText = grounpModel.context;
    mobileAlbumVC.photos = cellArr;
    
    [self.navigationController pushViewController:mobileAlbumVC animated:YES];
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
