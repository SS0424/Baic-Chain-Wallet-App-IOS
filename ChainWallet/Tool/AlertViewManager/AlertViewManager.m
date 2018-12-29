//
//  AlertViewManager.m
//  ChainWallet
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AlertViewManager.h"
#import <LEEAlert/LEEAlert.h>
#import "UIButton+EnlargeTouchArea.h"
#import "UIImage+AddCategory.h"
#import <Toast/UIView+Toast.h>
@implementation AlertViewManager
- (void)showQRCodeImageAlert{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(315), kScaleX(342))];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(315), kScaleX(82))];
    topView.backgroundColor = kBlueColor;
    [contentView addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [topView addSubview:titleLabel];
    titleLabel.textColor = kUIColorWithRGB(255, 255, 255);
    titleLabel.font = kUIFontWithMediumSize(kScaleX(18));
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(topView).offset(kScaleX(14));
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [topView addSubview:closeBtn];
    [closeBtn setImage:kUIImageNamed(@"btn_alert_close") forState:UIControlStateNormal];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(topView).offset(kScaleX(-18));
    }];
    [closeBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 关闭当前显示的Alert或ActionSheet
        [LEEAlert closeWithCompletionBlock:^{
            //如果在关闭后需要做一些其他操作 建议在该Block中进行
        }];
    }];
    
    /*
    UILabel *addressLabel = [[UILabel alloc]init];
    [topView addSubview:addressLabel];
    addressLabel.textColor = kUIColorWithRGB(255, 255, 255);
    addressLabel.font = kUIFontWithRegularSize(kScaleX(12));
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.width.equalTo(@(kScaleX(160)));
        make.top.equalTo(titleLabel.mas_bottom).offset(kScaleX(10));
    }];
    
    UIButton *ccopyBtn = [[UIButton alloc]init];
    [topView addSubview:ccopyBtn];
    [ccopyBtn setImage:kUIImageNamed(@"btn_hone_copy") forState:UIControlStateNormal];
    [ccopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLabel);
        make.left.equalTo(addressLabel.mas_right).offset(kScaleX(10));
    }];
    [ccopyBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [[ccopyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = [AccountManager sharedManager].current_baicPublicKey;
        
        [CSToastManager setQueueEnabled:YES];
        UIView *window = [UIApplication sharedApplication].keyWindow;
        //[window makeToast:@"copy success" duration:2.0 position:];
        [window makeToast:@"copy success" duration:2 position:CSToastPositionCenter];

    }];
    */
     
    UIImageView *qrImgView = [[UIImageView alloc]init];
    [contentView addSubview:qrImgView];
    [qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kScaleX(140), kScaleX(140)));
        make.bottom.equalTo(contentView).offset(kScaleX(-60));
    }];
    
    UIImage *qrImage = [UIImage createQRImageWithString:[NSString stringWithFormat:@"BAICCHAIN:%@",ACCOUNT_NAME_VALUE] AndSize:CGSizeMake(kScaleX(140), kScaleX(140))];
    qrImgView.image = qrImage;
    
#warning debug by zcw
    titleLabel.text = [AccountManager sharedManager].current_account_name;
    //addressLabel.text = [AccountManager sharedManager].current_baicPublicKey;
    
    [LEEAlert alert].config.LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = contentView;
        custom.isAutoWidth = NO;
    }).LeeClickBackgroundClose(YES)
    .LeeBackGroundColor(kUIColorWithRGB(31, 39, 55))
    .LeeBackgroundStyleTranslucent(0.9f)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeMaxWidth(kScaleX(315))
    .LeeMaxHeight(kScaleX(342))
    .LeeShow();
}
@end
