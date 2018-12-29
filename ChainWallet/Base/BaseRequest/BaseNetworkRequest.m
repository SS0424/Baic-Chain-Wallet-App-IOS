//
//  BaseNetworkRequest.m
//  ChainWallet
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseNetworkRequest.h"
#import <UIView+Toast.h>
#import "AFHTTPSessionManager+Leak.h"

@implementation BaseNetworkRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void) postDataSuccess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    
    id parameters = self.param;
    NSString *urlStr = self.requestUrlPath;
    DLog(@"parameters = %@",parameters);
    DLog(@"urlStr = %@",urlStr);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"responseObject = %@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error = %@",error);
        [[UIApplication sharedApplication].keyWindow makeToast:@"error"];
        failure(task, error);
    }];
}

- (void)getDataSusscess:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    id parameters = self.param;
    NSString *urlStr = self.requestUrlPath;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];

    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"responseObject = %@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error = %@",error);
        [[UIApplication sharedApplication].keyWindow makeToast:@"error"];
        failure(task, error);
    }];
    

}

#pragma mark Build request interface address
- (NSString *)requestUrlPath{
    return @"";
}


/*
+ (void)postWithUrl:(NSString *)requestUrl params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    DLog(@"params = %@",params);
    [manager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"responseObject = %@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error = %@",error);
        failure(error);
    }];
}

+ (void)getWithUrl:(NSString *)requestUrl params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailedBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //[securityPolicy setValidatesDomainName:NO];
    //securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES
    //manager.securityPolicy = securityPolicy;
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html",@"charset=UTF-8",nil];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    [manager GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
 */
@end
