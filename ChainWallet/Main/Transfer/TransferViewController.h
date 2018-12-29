//
//  TransferViewController.h
//  ChainWallet
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseViewController.h"
#import "TokenModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TransferViewController : BaseViewController
- (instancetype)initWithViewControllerModel:(TokenModel *)model;

@property (copy,nonatomic) NSString *address;

@end

NS_ASSUME_NONNULL_END
