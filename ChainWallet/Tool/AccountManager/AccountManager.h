//
//  AccountManager.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
#import "AccountPermission.h"
#import "AccountPerKeys.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^DataSourceBlock)(void);

@interface AccountManager : NSObject
//私钥 创建时使用
@property (copy,nonatomic) NSString *baicPrivateKey;

//公钥 创建时使用
@property (copy,nonatomic) NSString *baicPublicKey;
//账户名 创建时使用
@property (copy,nonatomic) NSString *account_name;
//账户名
@property (copy,nonatomic) NSString *current_account_name;
//智能合约
@property (copy,nonatomic) NSString *code;

+ (AccountManager *)sharedManager;

//token
@property (strong,nonatomic) NSArray *tokenArray;
//存储信息
- (void)saveAccountInfoWithKey:(NSString *)key;

- (BOOL)varifyAccountWithModel:(AccountModel *)model;

- (void)changeRootViewController;

- (NSArray *)account_nameArray;
- (NSArray *)current_account_info;

@end

NS_ASSUME_NONNULL_END
