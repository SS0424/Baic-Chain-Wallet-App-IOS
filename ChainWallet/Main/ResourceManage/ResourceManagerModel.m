//
//  ResourceManagerModel.m
//  ChainWallet
//
//  Created by apple on 2018/12/14.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "ResourceManagerModel.h"

@implementation ResourceManagerModel
+ (JSONKeyMapper *)keyMapper{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"max":@"cpu_limit.max",
                                                                                  @"used":@"cpu_limit.used"
                                                                                  }];
    return mapper;
}
@end
