//
//  AccountInfoKeysModel.m
//  ChainWallet
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AccountInfoKeysModel.h"

@implementation AccountInfoKeysModel
/**
 如果需要指定“唯一约束”字段, 在模型.m文件中实现该函数,这里指定 name和age 为“唯一约束”.
 */
//+(NSArray *)bg_uniqueKeys{
//    return @[@"account_name",@"perm_name"];
//}

/**
 自定义“联合主键” ,这里指定 name和age 为“联合主键”.
 */
+(NSArray *)bg_unionPrimaryKeys{
    return @[@"account_name"];
}
@end
