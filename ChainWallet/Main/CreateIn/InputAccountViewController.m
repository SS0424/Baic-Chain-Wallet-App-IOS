//
//  InputAccountViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "InputAccountViewController.h"
#import "AccountModel.h"
#import "GetAccoutRequest.h"
#import "SetTradePwdViewController.h"

@interface InputAccountViewController ()
@property (strong,nonatomic) UITextField *accountTextField;
@property (strong,nonatomic) UIButton *nextBtn;

@end

@implementation InputAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.base_titleLabel.text = NSLocalizedString(@"输入账号", nil);
    
    [self createUI];
    [self createRAC];
}

- (void)createRAC{
    
#define debug
    @weakify(self);
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        //检验账号是否存在
        [self varifyAccountExist];
    }];
}

- (void)varifyAccountExist{
    
    NSArray *accountArray = [AccountManager sharedManager].account_nameArray;
    if ([accountArray containsObject:_accountTextField.text]) {
        return;
    }
    
    @weakify(self);
    [[[GetAccoutRequest alloc]initWithAccountName:_accountTextField.text] postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
        //成功，账号存在 验证公钥是否匹配  设置交易密码
        AccountModel *model = [[AccountModel alloc]initWithDictionary:data error:nil];
        BOOL b = [[AccountManager sharedManager]varifyAccountWithModel:model];
        if (b) {
            SetTradePwdViewController *view = [[SetTradePwdViewController alloc]init];
            view.accountName = self.accountTextField.text;
            [self.navigationController pushViewController:view animated:YES];
        }
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (void)createUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = kFontBlackColor;
    titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(50));
        make.top.equalTo(self.base_titleLabel.mas_bottom).offset(kScaleX(40));
    }];
    titleLabel.text = NSLocalizedString(@"输入BAIC账号", nil);
    
    _accountTextField = [[UITextField alloc]init];
    [self.view addSubview:_accountTextField];
    _accountTextField.placeholder = NSLocalizedString(@"账号名", nik);
    _accountTextField.layer.borderWidth = 1;
    _accountTextField.layer.cornerRadius = kScaleX(6);
    _accountTextField.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
    _accountTextField.leftViewMode = UITextFieldViewModeAlways;
    _accountTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(10), kScaleX(40))];
    _accountTextField.font = kUIFontWithMediumSize(kScaleX(14));
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).offset(kScaleX(20));
        make.size.mas_equalTo(CGSizeMake(kScaleX(275), kScaleX(40)));
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
