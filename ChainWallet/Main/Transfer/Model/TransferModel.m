//
//  TransferModel.m
//  ChainWallet
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TransferModel.h"

@implementation TransferModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"timestamp":@"head_block_time",
                                                            @"ref_block_prefix":@"last_irreversible_block_ref_prefix",
                                                                 @"head_block_num":@"last_irreverisble_block_ref_num"
                                                                 }];
}

//+ (JSONKeyMapper *)keyMapper{
//    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"timestamp":@"head_block_time",
//                                                                 @"ref_block_prefix":@"last_irreversible_block_ref_prefix"
//                                                                 }];
//}
@end
