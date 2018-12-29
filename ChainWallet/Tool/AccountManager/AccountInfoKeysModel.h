//
//  AccountInfoKeysModel.h
//  ChainWallet
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"
#import <BGFMDB/BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoKeysModel : JSONModel

@property (copy,nonatomic) NSString *account_name;

@property (copy,nonatomic) NSString *perm_name;

@property (copy,nonatomic) NSString *key;

@end

NS_ASSUME_NONNULL_END
