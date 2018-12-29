//
//  ExportPrivateKeyTableViewCell.h
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
//#import <YYImage.h>
//#import <YYAnimatedImageView.h>
#import "ExportPrivateKeyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExportPrivateKeyTableViewCell : UITableViewCell
//角色
@property (strong,nonatomic) UILabel *roleLabel;
//公钥
@property (strong,nonatomic) UILabel *ppublicLabel;
//私钥
@property (strong,nonatomic) YYLabel *pprivateLabel;
//复制按钮
@property (strong,nonatomic) UIButton *ccopyBtn;

@property (strong,nonatomic) ExportPrivateKeyModel *infoModel;
@end

NS_ASSUME_NONNULL_END
