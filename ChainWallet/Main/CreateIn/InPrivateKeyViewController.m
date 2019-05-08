//
//  InPrivateKeyViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "InPrivateKeyViewController.h"
#import <YYText/YYTextView.h>
#import "AccountManager.h"
#import "AESCrypt.h"
@interface InPrivateKeyViewController ()
@property (strong,nonatomic) YYTextView *keyTextView;
@property (strong,nonatomic) UIButton *nextBtn;
@end

@implementation InPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.base_titleLabel.text = NSLocalizedString(@"导入私钥", nil);
   
    [self createUI];
    
    [self createRAC];
    
}

- (void)createRAC{
#define debug

    @weakify(self);
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [AccountManager sharedManager].baicPrivateKey = self.keyTextView.text;
    
        UIViewController *view = [NSClassFromString(@"InputAccountViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }];
}

- (void)createUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = kFontBlackColor;
    titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScaleX(30));
        make.top.equalTo(self.base_titleLabel.mas_bottom).offset(kScaleX(40));
    }];
    titleLabel.text = NSLocalizedString(@"输入私钥", nil);
    
    _keyTextView = [[YYTextView alloc]init];
    [self.view addSubview:_keyTextView];
    _keyTextView.placeholderText = NSLocalizedString(@"输入私钥", nik);
    _keyTextView.placeholderTextColor = kUIColorWithRGB(178, 178, 178);
    _keyTextView.placeholderFont = kUIFontWithMediumSize(kScaleX(14));
    _keyTextView.layer.borderWidth = 1;
    _keyTextView.layer.cornerRadius = kScaleX(6);
    _keyTextView.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
    [_keyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).offset(kScaleX(20));
        make.size.mas_equalTo(CGSizeMake(kScaleX(315), kScaleX(200)));
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
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_keyTextView resignFirstResponder]; // 空白处收起
}
@end
