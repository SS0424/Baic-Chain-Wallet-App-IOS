//
//  ResourceManagerModel.h
//  ChainWallet
//
//  Created by apple on 2018/12/14.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResourceManagerModel : JSONModel

@property (assign,nonatomic) CGFloat used;
@property (assign,nonatomic) CGFloat max;

@property (assign,nonatomic) CGFloat ram_usage;
@property (assign,nonatomic) CGFloat ram_quota;

@end

NS_ASSUME_NONNULL_END
