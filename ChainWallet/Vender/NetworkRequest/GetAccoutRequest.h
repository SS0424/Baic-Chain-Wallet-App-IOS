//
//  GetAccoutRequest.h
//  ChainWallet
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetAccoutRequest : BaseNetworkRequest
- (instancetype)initWithAccountName:(NSString *)accountName;
@end

NS_ASSUME_NONNULL_END
