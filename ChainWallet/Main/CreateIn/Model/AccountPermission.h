//
//  AccountPermission.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"
#import "AccountPerKeys.h"
NS_ASSUME_NONNULL_BEGIN

@protocol  AccountPerKeys

@end

@interface AccountPermission : JSONModel
@property (copy,nonatomic)   NSString *perm_name;
@property (strong,nonatomic) NSArray <AccountPerKeys> *keys;
@end

NS_ASSUME_NONNULL_END
