//
//  DTPhotosBaseViewController.m
//  PhotosTest
//
//  Created by lsq on 2017/8/14.
//  Copyright © 2017年 杜蒙. All rights reserved.
//

#import "DTPhotosBaseViewController.h"
#import "Masonry.h"

@interface DTPhotosBaseViewController ()

@property (nonatomic, strong) UIView *top;
@property (nonatomic, strong) UIButton *left;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation DTPhotosBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
}

- (void)initNav{
    
    self.top = [UIView new];
    self.top.backgroundColor = [UIColor whiteColor];
    
    self.left = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.left setImage:[UIImage imageNamed:@"返回-点击2"] forState:UIControlStateNormal];
    [self.left addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = self.titleText;
    
    
    UIView *bottomline = [UIView new];
    bottomline.backgroundColor  = [UIColor groupTableViewBackgroundColor];

    
    [self.view addSubview:self.top];
    [self.top addSubview:self.left];
    [self.top addSubview:self.titleLabel];
    [self.top addSubview:bottomline];
    
    __weak typeof(self) weak = self;
    [self.top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@64);
    }];
    
    [self.left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@32);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weak) self = weak;
        make.top.equalTo(@31);
        make.centerX.mas_equalTo(self.top.mas_centerX);
    }];
    
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@-0.5);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    self.selectBtn = [[UIButton alloc] init];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectBtn setTitle:@"选择" forState:UIControlStateNormal];
    [self.selectBtn setTitle:@"取消" forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self.top addSubview:self.selectBtn];
    self.selectBtn.selected = NO;
    self.selectBtn.hidden = self.hiddeSelectBtn;
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-23);
        make.top.equalTo(@31);
    }];
    
}

- (void)setHiddeSelectBtn:(BOOL)hiddeSelectBtn{
    _hiddeSelectBtn = hiddeSelectBtn;
    self.selectBtn.hidden = _hiddeSelectBtn;
}

- (void)select:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.selectBtnBlock) {
        self.selectBtnBlock(btn.selected);
    }
}

- (void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}

- (void)back{
    if (self.backblock) {
        self.backblock();
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
