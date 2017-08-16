//
//  DTPhotosCollectionBaseViewController.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosCollectionBaseViewController.h"
#import "DTPhotosCollectionViewCell.h"
#import "Masonry.h"

@interface DTPhotosCollectionBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) DTPhotosBottomView *bottomView;

@end

@implementation DTPhotosCollectionBaseViewController

- (void)dealloc{
    
}

- (NSMutableArray *)selecteds{
    if (!_selecteds) {
        _selecteds = [[NSMutableArray alloc] init];
    }
    return _selecteds;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (UICollectionView *)photosCollectionView{
    if (!_photosCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(8, 6, 0, 6);
        UICollectionView *photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
        photosCollectionView.delaysContentTouches = NO;
        photosCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        photosCollectionView.delegate = self;
        photosCollectionView.dataSource = self;
        [photosCollectionView registerClass:[DTPhotosCollectionViewCell class] forCellWithReuseIdentifier:@"id"];
        [self.view addSubview:_photosCollectionView = photosCollectionView];
    }
    return _photosCollectionView;
}

- (DTPhotosBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[DTPhotosBottomView alloc] init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@49);
            make.bottom.equalTo(@0);
        }];
        _bottomView.sourceType = [[self.photos firstObject] sourceType];
        _bottomView.hidden = YES;
        _bottomView.deleteBlock = self.deleteBlock;
        _bottomView.shareBlock = self.shareBlock;
        _bottomView.cloudBlock = self.cloudBlock;
        _bottomView.downloadBlock = self.downloadBlock;
    }
    return _bottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self photosCollectionView];
}

- (void)setisSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (!isSelect) {
        // 取消选中状态，全部职位未选中
        [self.selecteds removeAllObjects];
        for (int i = 0; i < self.photos.count; i ++) {
            DTPhotosCollectionCellModel *cellModel = [self.photos objectAtIndex:i];
            cellModel.isSelect = NO;
        }
        self.bottomView.hidden = YES;
        self.bottomView.selectCount = 0;
    }
    [self.photosCollectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DTPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    if (self.photos.count > indexPath.row) {
        DTPhotosCollectionCellModel *cellModel = (DTPhotosCollectionCellModel *)[self.photos objectAtIndex:indexPath.row];
        cell.cellModel = cellModel;
        cell.isSelect = self.isSelect;  // 能否选中
        return cell;
    }else{
        NSLog(@"列表为空");
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(196, 121);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DTPhotosCollectionCellModel *cellModel = [self.photos objectAtIndex:indexPath.row];
    if (self.isSelect) {
        // 选择
        cellModel.isSelect = !cellModel.isSelect;
        if (cellModel.isSelect) {
            [self.selecteds addObject:cellModel];
        }else{
            if ([self.selecteds containsObject:cellModel]) {
                [self.selecteds removeObject:cellModel];
            }else{
                NSLog(@"选中的文件不存在");
            }
        }
        if (self.selecteds.count) {
            self.bottomView.hidden = NO;
        }else{
            self.bottomView.hidden = YES;
        }
        self.bottomView.selectCount = (int)self.selecteds.count;
        
        [self.photosCollectionView reloadData];
    }else{
        // 跳转
        if (self.cellDidClick) {
            self.cellDidClick(cellModel);
        }
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
