//
//  WalletPopView.m
//  ChainWallet
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 zcw. All rights reserved.
//
#import "WalletPopView.h"
#import "NumsFieldView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIButton+EnlargeTouchArea.h"
@interface WalletPopView ()
//类型
@property (assign,nonatomic) WalletPopViewType popType;
//数据
@property (strong,nonatomic) NSDictionary *dataDict;
//标题
@property (strong,nonatomic) UILabel *titleLabel;
//内容view
@property (strong,nonatomic) UIView *contentView;
//取消按钮
@property (strong,nonatomic) UIButton *closeBtn;
//支付密码
@property (strong,nonatomic) UITextField *pwdTextField;
//阴影背景
@property (strong,nonatomic) UIView *backgroundView;

@end

@implementation WalletPopView

- (instancetype)initWithType:(WalletPopViewType)type BackgroundView:(UIView *) backgroundView WithDataDictionary:(NSDictionary *)dataDic{
    self = [super init];
    if (self) {
        _popType = type;
        _dataDict =dataDic;
        
        [self initView];
    }
    return self;
}

- (void)initView{
    @weakify(self);
    self.backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:self.backgroundView];
    _backgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [_backgroundView addGestureRecognizer:tap];
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
        @strongify(self);
        //[self hidden];
        [self endEditing:YES];
    }];
    
    
    if (_popType == WalletPopViewTypePayPassword) {
        [IQKeyboardManager sharedManager].enable = NO;
        
        //键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
        //键盘消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];

        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScaleX(140))];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];

        _closeBtn = [[UIButton alloc]init];
        [_contentView addSubview:_closeBtn];
        [_closeBtn setImage:kUIImageNamed(@"btn_pop_btn_close") forState:UIControlStateNormal];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(15));
            make.top.equalTo(self.contentView).offset(kScaleX(20));
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        [_closeBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self endEditing:YES];
        }];
        
        self.pwdTextField = [[UITextField alloc]init];
        [_contentView addSubview:self.pwdTextField];
        _pwdTextField.layer.cornerRadius = kScaleX(6);
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
        _pwdTextField.layer.borderWidth = 1;
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
        [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kScaleX(72));
            make.left.equalTo(self.contentView).offset(kScaleX(24));
            make.right.equalTo(self.contentView).offset(kScaleX(-24));
            make.height.equalTo(@(kScaleX(40)));
        }];
        [_pwdTextField becomeFirstResponder];
        
        
        UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScaleX(66), kScaleX(40))];
        [commitBtn setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [commitBtn setTitleColor:kUIColorWithRGB(255, 255, 255) forState:UIControlStateNormal];
        commitBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
        commitBtn.backgroundColor = kBlueColor;
        
        @weakify(self);
        [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if (self.commitBlock) {
                self.commitBlock(self.pwdTextField.text);
            }
            [self endEditing:YES];
        }];
        
        
        //设置圆角
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:commitBtn.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(kScaleX(6), kScaleX(6))];
        CAShapeLayer * layer = [[CAShapeLayer alloc]init];
        layer.frame = commitBtn.bounds;
        layer.path = path.CGPath;
        commitBtn.layer.mask = layer;
        _pwdTextField.rightView = commitBtn;
        
        
        
        _titleLabel = [[UILabel alloc]init];
        [_contentView addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kUIFontWithMediumSize(kScaleX(18));
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = NSLocalizedString(@"输入支付密码", nil);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.closeBtn);
            make.centerX.equalTo(self.contentView);
        }];
        
        
        UIWindow *window = [[UIApplication sharedApplication] delegate].window;
        self.frame = window.frame;
        [window addSubview:self];
        
    }
}


- (void) showKeyBoard:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
 //   DLog(@"keyBoardEndY = %f",keyBoardEndY);
    // 得到键盘弹出后的键盘视图所在y坐标
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // 添加移动动画，使视图跟随键盘移动
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.contentView.frame = CGRectMake(0, keyBoardEndY - kScaleX(140), kScreenWidth, kScaleX(140));
        self.backgroundView.backgroundColor = [kUIColorWithRGB(31, 31, 55) colorWithAlphaComponent:0.8];
    } completion:^(BOOL finished) {
    }];
    
}

- (void)hideKeyBoard:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
//    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
//    DLog(@"keyBoardEndY = %f",keyBoardEndY);
    // 得到键盘结束的键盘视图所在y坐标
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScaleX(140));
        self.backgroundView.backgroundColor = [kUIColorWithRGB(31, 31, 55) colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }];
    
}
@end
