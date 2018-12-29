//
//  TransferRequest.h
//  ChainWallet
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TransferBlock)(void);

@interface TransferRequest : BaseNetworkRequest
- (instancetype)initWithTo:(NSString *)to Quantity:(NSString *)quantity Wif:(NSString *)wif PubkeyArray:(NSArray *)keyarray;

- (void)transferToekn;

@property (copy,nonatomic) TransferBlock success;

@end

NS_ASSUME_NONNULL_END
