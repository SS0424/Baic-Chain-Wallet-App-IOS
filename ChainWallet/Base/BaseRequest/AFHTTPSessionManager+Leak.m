//
//  AFHTTPSessionManager+Leak.m
//  BaicStarryNight
//
//  Created by JiangShan on 2018/4/10.
//  Copyright © 2018年 NAKUPENDA. All rights reserved.
//

#import "AFHTTPSessionManager+Leak.h"

@implementation AFHTTPSessionManager (Leak)

static AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        manager = [[AFHTTPSessionManager alloc] init];
    });
    
    return manager;
}

@end
