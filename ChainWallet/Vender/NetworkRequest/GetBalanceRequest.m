//
//  GetBanlanceRequest.m
//  ChainWallet
//
//  Created by apple on 2018/12/18.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "GetBalanceRequest.h"
#import "TokenModel.h"
@interface GetBalanceRequest ()
@property (copy,nonatomic) NSString *code;
@property (copy,nonatomic) NSString *account;
@property (copy,nonatomic) NSArray *symbolArray;
@property (copy,nonatomic) NSString *symbol;
@end

@implementation GetBalanceRequest

- (instancetype)initWithCode:(NSString *)code Account:(NSString *)account Symbol:(NSArray *)symbolArray{
    self = [super init];
    if (self) {
        _code = code;
        _account = account;
        _symbolArray = symbolArray;
        
    }
    return self;
}

- (NSString *)requestUrlPath{
    return HTTP_GET_CURRENCY_BALANCE;
}

- (void)didloadBalanceDataSourceResultSuccess:(ResultSuccessBlock)success failure:(ResultFailureBlock)failure{
    NSMutableArray *dataSource = [NSMutableArray new];
    NSMutableArray *tokenModelArray = [NSMutableArray new];

    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue=dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < _symbolArray.count; i++) {
        dispatch_group_async(group, queue, ^{
            self.symbol = self.symbolArray[i];
            NSString *code = @"baic.token";
            if ([self.symbol isEqualToString:@"BAIC"]) {
                code = @"baic";
            }
            NSDictionary *params = @{@"code":code,
                                    @"account":self.account,
                                    @"symbol":self.symbol
                                    };
            self.param = params;
            
            [self postDataSuccess:^(id  _Nonnull data) {
                //信号量数值+1
                [dataSource addObject:data];
                dispatch_semaphore_signal(semaphore);
            } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
                failure();
                return ;
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        });
    }
    dispatch_group_notify(group, queue, ^{
        //所有请求返回数据后执行
        for (int i = 0; i < dataSource.count; i++) {
            NSArray *array1 = dataSource[i];
            for (int j = 0; j<array1.count; j++) {
                NSString *tokenString = array1[j];
                if (tokenString.length > 0) {
                    NSArray *tempArray = [tokenString componentsSeparatedByString:@" "];
                    NSDictionary *tokenDict = @{@"token":[tempArray lastObject],
                                                @"count":[tempArray firstObject]
                                                };
                    TokenModel *model = [[TokenModel alloc]initWithDictionary:tokenDict error:nil];
                    [tokenModelArray addObject:model];
                }
            }
        }
        [AccountManager sharedManager].tokenArray = [NSArray arrayWithArray:tokenModelArray];
        success();
    });
}
@end
