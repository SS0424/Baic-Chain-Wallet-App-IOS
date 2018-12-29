//
//  TransferViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TransferViewController.h"
#import <YYCategories/UIImage+YYAdd.h>
#import "UIButton+EnlargeTouchArea.h"
#import "WalletPopView.h"
#import "AESCrypt.h"
#import "AccountInfoModel.h"
#import "TransferRequest.h"
#import "ScanViewController.h"

@interface TransferViewController ()
//金额
@property (strong,nonatomic) UITextField *sumTextField;
//token
@property (strong,nonatomic) UILabel *tokenLabel;
//余额
@property (strong,nonatomic) UILabel *balanceLabel;
//地址
@property (strong,nonatomic) UILabel *addressLabel;
//收款地址
@property (strong,nonatomic) UITextField *addressTextField;
//下一步
@property (strong,nonatomic) UIButton *nextBtn;
//扫一扫
@property (strong,nonatomic) UIButton *rightNavBtn;
@property (strong,nonatomic) TokenModel *tokenModel;
@property (strong,nonatomic) TransferRequest *requet;
@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kUIColorWithRGB(242, 243, 244);
    
    [self createUI];
    
    [self createNav];
    
    [self createRAC];
}

- (instancetype)initWithViewControllerModel:(TokenModel *)model{self = [super init];
    if (self) {
        self.tokenModel = model;
    }
    return self;

    
}

- (void)createRAC{

    @weakify(self);
#warning debug by zcw
    if (self.address) {
        _addressTextField.text = self.address;
    }
    
    
    self.base_titleLabel.text = [NSString stringWithFormat:@"%@%@",_tokenModel.token,NSLocalizedString(@"转账", nil)];
    _tokenLabel.text = _tokenModel.token;
    _balanceLabel.text = [NSString stringWithFormat:@"%@：%@ %@",NSLocalizedString(@"余额", nil),_tokenModel.count,_tokenModel.token];
    
    
    RAC(self.nextBtn,enabled) = [RACSignal combineLatest:@[self.sumTextField.rac_textSignal,self.addressTextField.rac_textSignal] reduce:^(NSString *sum,NSString *address){
        return @(sum.length > 0 && address.length > 0);
    }];
    
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        WalletPopView *popView = [[WalletPopView alloc]initWithType:WalletPopViewTypePayPassword BackgroundView:self.view WithDataDictionary:nil];
        popView.commitBlock = ^(NSString * _Nonnull pwd) {
            if (pwd.length == 0) {
                return ;
            }
            [self pwdVerify:pwd];
        };
    }];
    
    
    [[_rightNavBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        ScanViewController *scan = [[ScanViewController alloc]init];

        @weakify(self);
        scan.success = ^(NSString * _Nonnull address) {
            @strongify(self);
            if ([address hasPrefix:@"BAICCHAIN:"]) {
                [self.navigationController popViewControllerAnimated:YES];

                NSString *addressStr = [address stringByReplacingOccurrencesOfString:@"BAICCHAIN:" withString:@""];
                self.addressTextField.text = addressStr;
            }
            
        };
        [self.navigationController pushViewController:scan animated:YES];
    }];
    
}

- (void)pwdVerify:(NSString *)pwd{
    NSArray *array = [[AccountManager sharedManager]current_account_info];
    AccountInfoModel *model =[array firstObject];
    NSString *acwif = [AESCrypt decrypt:model.active_privatekey password:pwd];
    NSString *countStr = [NSString stringWithFormat:@"%.9f",[_sumTextField.text doubleValue]];
    NSString *quantity = [NSString stringWithFormat:@"%@ %@",countStr,_tokenModel.token];
    NSMutableArray *keyArray = [NSMutableArray array];
    [keyArray addObject:[AESCrypt decrypt:model.active_publickey password:pwd]];
    [keyArray addObject:[AESCrypt decrypt:model.owner_publickey password:pwd]];

    if (acwif.length > 0 ) {
        _requet = [[TransferRequest alloc] initWithTo:_addressTextField.text Quantity:quantity Wif:acwif PubkeyArray:keyArray];
        [_requet transferToekn];
        @weakify(self);
        _requet.success = ^{
            @strongify(self);
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
    }
}



- (void)createNav{
    _rightNavBtn = [[UIButton alloc]init];
    [self.base_navView addSubview:_rightNavBtn];
    [_rightNavBtn setImage:kUIImageNamed(@"nav_scan_small") forState:UIControlStateNormal];
    [_rightNavBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.base_navView).offset(-kScaleX(15));
        make.centerY.equalTo(self.base_returnBtn);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

}

- (void)createUI{
    UIView *bgView1 = [[UIView alloc]init];
    [self.view addSubview:bgView1];
    bgView1.backgroundColor = kUIColorWithRGB(255, 255, 255);
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScaleX(67)));
        make.top.equalTo(self.view).offset(kNavigationBarHeight + kScaleX(10));
    }];

    UIView *bgView2 = [[UIView alloc]init];
    [self.view addSubview:bgView2];
    bgView2.backgroundColor = kUIColorWithRGB(255, 255, 255);
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScaleX(67)));
        make.top.equalTo(bgView1.mas_bottom).offset(kScaleX(10));
    }];
    
    
    _tokenLabel = [[UILabel alloc]init];
    [bgView1 addSubview:_tokenLabel];
    _tokenLabel.textColor = kUIColorWithRGB(67, 86, 99);
    _tokenLabel.font = kUIFontWithSemiboldSize(kScaleX(12));
    [_tokenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(kScaleX(16));
        make.top.equalTo(bgView1).offset(kScaleX(10));
    }];

    _balanceLabel = [[UILabel alloc]init];
    [bgView1 addSubview:_balanceLabel];
    _balanceLabel.textColor = kBlueColor;
    _balanceLabel.font = kUIFontWithSemiboldSize(kScaleX(12));
    _balanceLabel.textAlignment = NSTextAlignmentRight;
    [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView1).offset(-kScaleX(16));
        make.top.equalTo(bgView1).offset(kScaleX(10));
    }];
    
    _sumTextField = [[UITextField alloc]init];
    [bgView1 addSubview:_sumTextField];
    _sumTextField.textColor = kUIColorWithRGB(67, 86, 99);
    _sumTextField.font = kUIFontWithMediumSize(kScaleX(16));
    _sumTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [_sumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(kScaleX(16));
        make.bottom.equalTo(bgView1).offset(-kScaleX(11));
    }];
    _sumTextField.placeholder = NSLocalizedString(@"输入金额", nil);

    
    _addressLabel = [[UILabel alloc]init];
    [bgView2 addSubview:_addressLabel];
    _addressLabel.textColor = kUIColorWithRGB(67, 86, 99);
    _addressLabel.font = kUIFontWithSemiboldSize(kScaleX(12));
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView2).offset(kScaleX(16));
        make.top.equalTo(bgView2).offset(kScaleX(10));
    }];
    _addressLabel.text = NSLocalizedString(@"收款地址", nil);

    _addressTextField = [[UITextField alloc]init];
    [bgView2 addSubview:_addressTextField];
    _addressTextField.textColor = kUIColorWithRGB(67, 86, 99);
    _addressTextField.font = kUIFontWithMediumSize(kScaleX(16));
    _addressTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [_addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView2).offset(kScaleX(16));
        make.bottom.equalTo(bgView2).offset(-kScaleX(11));
    }];
    _addressTextField.placeholder = NSLocalizedString(@"输入收款地址", nil);

    
    _nextBtn = [[UIButton alloc]init];
    [self.view addSubview:_nextBtn];
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = kScaleX(6);
    [_nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [_nextBtn setTitleColor:kUIColorWithRGB(255, 255, 255) forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:kBlueColor] forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:kUIColorWithRGB(194, 199, 203)] forState:UIControlStateDisabled];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(kScaleX(-70) - kSafeAreaBottomHeight);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScaleX(315), kScaleX(50)));
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
