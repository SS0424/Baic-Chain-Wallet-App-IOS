//
//  GetBanlanceRequest.h
//  ChainWallet
//
//  Created by apple on 2018/12/18.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseNetworkRequest.h"

typedef void(^ResultSuccessBlock)(void);
typedef void(^ResultFailureBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface GetBalanceRequest : BaseNetworkRequest
- (instancetype)initWithCode:(NSString *)code Account:(NSString *)account Symbol:(NSArray *)symbolArray;

- (void)didloadBalanceDataSourceResultSuccess:(ResultSuccessBlock)success failure:(ResultFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
