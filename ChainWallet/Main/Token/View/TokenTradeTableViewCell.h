//
//  TokenTradeTableViewCell.h
//  ChainWallet
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenTradeTableViewCell : UITableViewCell
//图片状态
@property (strong,nonatomic) UIImageView *stateImgView;
//token
@property (strong,nonatomic) UILabel *tokenNameLabel;
//时间
@property (strong,nonatomic) UILabel *timelabel;
//数量
@property (strong,nonatomic) UILabel *countLabel;
@end

NS_ASSUME_NONNULL_END
