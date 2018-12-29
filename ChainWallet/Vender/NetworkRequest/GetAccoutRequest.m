//
//  GetAccoutRequest.m
//  ChainWallet
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "GetAccoutRequest.h"
@interface GetAccoutRequest ()
@property (copy,nonatomic) NSString *accountName;
@end

@implementation GetAccoutRequest


- (instancetype)initWithAccountName:(NSString *)accountName{
    self = [super init];
    if (self) {
        self.accountName = accountName;
    }
    return self;
}

- (NSString *)requestUrlPath{
    return HTTP_CHAIN_GET_ACCOUNT;
}

- (NSDictionary *)param{
    return @{@"account_name":_accountName};
}

@end
