//
//  BaseViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+EnlargeTouchArea.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBgColor;
    [self setNavigationbar];
}

- (void)setNavigationbar{
    
    self.base_navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    [self.view addSubview:_base_navView];
    _base_navView.backgroundColor = kBgColor;
    
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight - kStatusBarHeight)];
    [_base_navView addSubview:barView];
    
    
    _base_returnBtn = [[UIButton alloc]init];
    [_base_returnBtn setImage:[UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    [barView addSubview:_base_returnBtn];
    [_base_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(barView).offset(15);
        make.centerY.equalTo(barView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_base_returnBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [_base_returnBtn addTarget:self action:@selector(base_customPopNavigationController) forControlEvents:UIControlEventTouchUpInside];
    
    _base_titleLabel = [[UILabel alloc]init];
    [barView addSubview:_base_titleLabel];
    _base_titleLabel.textColor = kUIColorWithRGB(67, 86, 99);
    _base_titleLabel.font = kUIFontWithMediumSize(kScaleX(18));
    _base_titleLabel.textAlignment = NSTextAlignmentCenter;
    [_base_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(barView).offset(kScaleX(50));
        //make.right.equalTo(barView).offset(-kScaleX(50));
        make.centerX.equalTo(barView);
        make.centerY.equalTo(barView);
    }];
}

- (void)base_customPopNavigationController{
    [self.navigationController popViewControllerAnimated:YES];
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
