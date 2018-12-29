//
//  CreateWalletViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "CreateWalletViewController.h"

@interface CreateWalletViewController ()
@property (strong,nonatomic) UIButton *nextBtn;
@end

@implementation CreateWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.base_titleLabel.text = NSLocalizedString(@"创建账号", nil);
    [self createUI];
    
    [self createRAC];
}

- (void)createRAC{
    @weakify(self);
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *view = [NSClassFromString(@"SetTradePwdViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

- (void)createUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = kFontBlackColor;
    titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.base_titleLabel.mas_bottom).offset(kScaleX(20));
        make.left.right.equalTo(self.view);
    }];
    titleLabel.text = NSLocalizedString(@"系统创建账号中，请等待2-3分钟", nil);
    
    UIImageView *waitImageView = [[UIImageView alloc]init];
    [self.view addSubview:waitImageView];
    waitImageView.image = kUIImageNamed(@"image_create_wait");
    [waitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).offset(kScaleX(40));
        make.size.mas_equalTo(CGSizeMake(kScaleX(150), kScaleX(104)));
    }];
    
    _nextBtn = [[UIButton alloc]init];
    [self.view addSubview:_nextBtn];
    [_nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    _nextBtn.layer.cornerRadius = kScaleX(6);
    _nextBtn.backgroundColor = kBlueColor;
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight - kScaleX(80));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScaleX(315), 40));
    }];
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
