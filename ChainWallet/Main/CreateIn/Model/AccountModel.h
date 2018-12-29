//
//  AccountModel.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"
#import "AccountPermission.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AccountPermission <NSObject>

@end

@interface AccountModel : JSONModel
@property (copy,nonatomic)   NSString *account_name;
@property (strong,nonatomic) NSArray <AccountPermission>*permissions;
@end

NS_ASSUME_NONNULL_END
