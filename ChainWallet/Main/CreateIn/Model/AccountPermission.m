//
//  AccountPermission.m
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AccountPermission.h"

@implementation AccountPermission
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"keys":@"required_auth.keys"}];
}
@end
