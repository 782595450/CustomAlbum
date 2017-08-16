//
//  ViewController.m
//  CustomAlbum
//
//  Created by lsq on 2017/8/16.
//  Copyright © 2017年 detu. All rights reserved.
//

#import "ViewController.h"
#import "DTPhotosGrounpViewController.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (strong , nonatomic) UITableView *tableView;
@property (strong , nonatomic) NSMutableArray *datas;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDataTitle:@"DTPhotosGrounpViewController"];
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}
- (void)addDataTitle:(NSString *)title {
    if (!self.datas) {
        self.datas = [NSMutableArray new];
    }
    [self.datas addObject:title];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            DTPhotosGrounpViewController *VC = [[DTPhotosGrounpViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }break;
        default:
            break;
    }
}

@end
