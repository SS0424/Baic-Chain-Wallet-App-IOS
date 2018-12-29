//
//  HomeAssetTableViewCell.h
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeAssetTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *chainNameLabel;
@property (strong,nonatomic) UILabel *addressLabel;
@property (strong,nonatomic) UIButton *ccopyBtn;
@property (strong,nonatomic) UIButton *morebtn;
@property (strong,nonatomic) UILabel *assetLabel;
@end

NS_ASSUME_NONNULL_END
