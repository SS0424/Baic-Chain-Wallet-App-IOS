//
//  WalletPopView.h
//  ChainWallet
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, WalletPopViewType) {
    WalletPopViewTypePayPassword = 0,//输入支付密码
};

typedef void(^PayPwdBlock)(NSString *pwd);
@interface WalletPopView : UIView
- (instancetype)initWithType:(WalletPopViewType)type BackgroundView:(UIView *) backgroundView WithDataDictionary:(NSDictionary *)dataDic;
@property (copy,nonatomic) PayPwdBlock commitBlock;
@end

NS_ASSUME_NONNULL_END
