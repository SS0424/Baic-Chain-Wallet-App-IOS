//
//  TokenModel.h
//  ChainWallet
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TokenModel : JSONModel
@property (copy,nonatomic) NSString *token;
@property (copy,nonatomic) NSString *count;
@end

NS_ASSUME_NONNULL_END
