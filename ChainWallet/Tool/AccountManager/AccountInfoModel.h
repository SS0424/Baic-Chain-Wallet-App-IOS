//
//  AccountInfoModel.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"
#import <BGFMDB/BGFMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoModel : JSONModel
@property (copy,nonatomic) NSString *account_name;

@property (copy,nonatomic) NSString *active_privatekey;

@property (copy,nonatomic) NSString *active_publickey;

@property (copy,nonatomic) NSString *owner_privatekey;

@property (copy,nonatomic) NSString *owner_publickey;
@end

NS_ASSUME_NONNULL_END
