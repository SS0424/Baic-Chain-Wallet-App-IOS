//
//  ExportPrivateKeyModel.h
//  ChainWallet
//
//  Created by apple on 2018/12/14.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExportPrivateKeyModel : JSONModel
@property (copy,nonatomic) NSString *perm_name;
@property (copy,nonatomic) NSString *account_name;
@property (copy,nonatomic) NSString *account_private_key;
@property (copy,nonatomic) NSString *account_public_key;
@end

NS_ASSUME_NONNULL_END
