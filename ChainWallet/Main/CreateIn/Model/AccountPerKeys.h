//
//  AccountPerKeys.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountPerKeys : JSONModel
@property (copy,nonatomic) NSString *key;
@property (copy,nonatomic) NSString *weight;
@end

NS_ASSUME_NONNULL_END
