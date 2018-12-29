//
//  BaseViewController.h
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(strong,nonatomic) UILabel *base_titleLabel;
@property(strong,nonatomic) UIView *base_navView;
@property(strong,nonatomic) UIButton *base_returnBtn;
- (void)base_customPopNavigationController;
@end

NS_ASSUME_NONNULL_END
