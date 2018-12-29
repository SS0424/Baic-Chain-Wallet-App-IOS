//
//  MainViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong,nonatomic) UIView *navView;
@property (strong,nonatomic) UIView *statusBarView;
@property (strong,nonatomic) UILabel *titleLabel;
//导入私钥
@property (strong,nonatomic) UIButton *putinBtn;
//创建钱包
@property (strong,nonatomic) UIButton *createBtn;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kBgColor;
    
    [self createNavView];
    
    [self createUI];
    
    [self createRAC];
}

- (void)createRAC{
    @weakify(self);
    //创建钱包
    [[_createBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *view = [NSClassFromString(@"CreateWalletViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }];
    
    //导入私钥
    [[_putinBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *view = [NSClassFromString(@"InPrivateKeyViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

- (void)createUI{
    UIImageView *logoImgView = [[UIImageView alloc]init];
    [self.view addSubview:logoImgView];
    logoImgView.image = kUIImageNamed(@"main_baic_logo");
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScaleX(121), kScaleX(58)));
        make.top.equalTo(self.view).offset(kNavigationBarHeight + kScaleX(90));
    }];
    
    _putinBtn = [[UIButton alloc]init];
    [self.view addSubview:_putinBtn];
    [_putinBtn setTitle:NSLocalizedString(@"导入私钥", nil) forState:UIControlStateNormal];
    _putinBtn.layer.cornerRadius = kScaleX(6);
    _putinBtn.layer.borderWidth = 1;
    [_putinBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    _putinBtn.layer.borderColor = kBlueColor.CGColor;
    _putinBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    [_putinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.right.equalTo(self.view).offset(-kScaleX(32));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScaleX(100), kScaleX(40)));
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight - kScaleX(80));
    }];

    /*
    _createBtn = [[UIButton alloc]init];
    [self.view addSubview:_createBtn];
    [_createBtn setTitle:NSLocalizedString(@"创建钱包", nil) forState:UIControlStateNormal];
    _createBtn.layer.cornerRadius = kScaleX(6);
    _createBtn.layer.borderWidth = 1;
    [_createBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    _createBtn.layer.borderColor = kBlueColor.CGColor;
    _createBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    [_createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(32));
        make.size.mas_equalTo(CGSizeMake(kScaleX(100), kScaleX(40)));
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight - kScaleX(80));
    }];
     */
}

- (void)createNavView{
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    _statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight)];
    [self.view addSubview:_statusBarView];
    _statusBarView.backgroundColor = kBgColor;
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight - kStatusBarHeight)];
    [self.view addSubview:_navView];
    _navView.backgroundColor = kBgColor;
    
    _titleLabel = [[UILabel alloc]init];
    [_navView addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = kBlackColor;
    _titleLabel.font = kUIFontWithMediumSize(kScaleX(18));
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.navView);
        make.centerY.equalTo(self.navView);
    }];
    _titleLabel.text = NSLocalizedString(@"佰客钱包", nil);
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
