//
//  TransferModel.h
//  ChainWallet
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransferModel : JSONModel
@property (copy,nonatomic) NSString *binargs;
@property (copy,nonatomic) NSString *head_block_num;
@property (copy,nonatomic) NSString *chain_id;
@property (copy,nonatomic) NSString *timestamp;
@property (copy,nonatomic) NSString *ref_block_prefix;

@end

NS_ASSUME_NONNULL_END
