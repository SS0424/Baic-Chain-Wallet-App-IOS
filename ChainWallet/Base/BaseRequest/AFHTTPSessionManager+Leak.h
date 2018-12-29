//
//  AFHTTPSessionManager+Leak.h
//  BaicStarryNight
//
//  Created by JiangShan on 2018/4/10.
//  Copyright © 2018年 NAKUPENDA. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Leak)

+ (AFHTTPSessionManager *)sharedManager;

@end
