//
//  BaseNetworkRequest.h
//  ChainWallet
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RequestSuccessBlock)(id data);
//typedef void(^RequestFailedBlock)(NSError *error);
typedef void(^RequestFailedBlock)(id task,NSError *error);


@interface BaseNetworkRequest : NSObject


@property(nonatomic, strong) NSDictionary *param;
@property(nonatomic, strong) NSString *requestUrlPath;

- (void)getDataSusscess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

- (void)postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure;

@end

NS_ASSUME_NONNULL_END
