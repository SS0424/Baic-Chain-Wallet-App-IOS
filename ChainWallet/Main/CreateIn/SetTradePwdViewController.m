//
//  SetTradePwdViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "SetTradePwdViewController.h"
#import "HomeViewController.h"

@interface SetTradePwdViewController ()
@property (strong,nonatomic) UITextField *pwdTextField;
@property (strong,nonatomic) UITextField *ensurePwdField;
@property (strong,nonatomic) UIButton *nextBtn;

@end

@implementation SetTradePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.base_titleLabel.text = NSLocalizedString(@"交易密码", nil);
    
    [self createUI];
    
    [self createRAC];
}

- (void)createRAC{
    RAC(self.nextBtn,enabled) = [RACSignal combineLatest:@[self.pwdTextField.rac_textSignal,self.ensurePwdField.rac_textSignal] reduce:^id(NSString *pwdString,NSString *ensurePwd){
        return @(pwdString.length != 0 && ensurePwd.length != 0 && [pwdString isEqualToString:ensurePwd]);
    }];
    
    @weakify(self);
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        
        //存储信息
        [[AccountManager sharedManager]saveAccountInfoWithKey:self.ensurePwdField.text];
    }];
}

// 登陆后淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

- (void)createUI{
    UILabel *label1 = [[UILabel alloc]init];
    [self.view addSubview:label1];
    label1.textColor = kFontBlackColor;
    label1.font = kUIFontWithMediumSize(kScaleX(14));
    label1.text = NSLocalizedString(@"输入交易密码", nil);
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(50));
        make.top.equalTo(self.base_titleLabel.mas_bottom).offset(kScaleX(62));
    }];
    
    _pwdTextField = [[UITextField alloc]init];
    [self.view addSubview:_pwdTextField];
    _pwdTextField.layer.cornerRadius = kScaleX(6);
    _pwdTextField.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
    _pwdTextField.layer.borderWidth = 1;
    _pwdTextField.secureTextEntry = YES;
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(50));
        make.right.equalTo(self.view).offset(-kScaleX(50));
        make.height.equalTo(@(kScaleX(40)));
        make.top.equalTo(label1.mas_bottom).offset(kScaleX(10));
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    [self.view addSubview:label2];
    label2.textColor = kFontBlackColor;
    label2.font = kUIFontWithMediumSize(kScaleX(14));
    label2.text = NSLocalizedString(@"确认交易密码", nil);
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(50));
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(kScaleX(20));
    }];
    
    _ensurePwdField = [[UITextField alloc]init];
    [self.view addSubview:_ensurePwdField];
    _ensurePwdField.layer.cornerRadius = kScaleX(6);
    _ensurePwdField.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
    _ensurePwdField.layer.borderWidth = 1;
    _ensurePwdField.secureTextEntry = YES;
    [_ensurePwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(50));
        make.right.equalTo(self.view).offset(-kScaleX(50));
        make.height.equalTo(@(kScaleX(40)));
        make.top.equalTo(label2.mas_bottom).offset(kScaleX(10));
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
