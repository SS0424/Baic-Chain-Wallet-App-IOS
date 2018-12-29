//
//  HomeTokenTableViewCell.h
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTokenTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImageView *tokenImgView;
@property (strong,nonatomic) UILabel *tokenNameLabel;
@property (strong,nonatomic) UILabel *tokenCountLabel;
@property (strong,nonatomic) UILabel *tokenValueLabel;
@property (strong,nonatomic) TokenModel *model;
@end

NS_ASSUME_NONNULL_END
