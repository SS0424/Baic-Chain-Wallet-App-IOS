
//
//  TransferRequest.m
//  ChainWallet
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TransferRequest.h"
#import "TransferModel.h"
#import "NSDate+ExFoundation.h"
#import "Sha256.h"
#import "BAICKey.h"
#import "BAICByteWriter.h"
#import "NSObject+Extension.h"
#import "NSData+Hash.h"
#import <UIView+Toast.h>
@interface TransferRequest ()
@property (copy,nonatomic) NSString *urlStr;

@property (copy,nonatomic) NSString *to;
@property (copy,nonatomic) NSString *quantity;
@property (copy,nonatomic) NSString *permission;
@property (copy,nonatomic) NSString *wif;
@property (copy,nonatomic) NSArray *keyArray;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *memo;

@property (strong,nonatomic) TransferModel *transferModel;
@property (strong,nonatomic) NSString *requirePubKey;
@end

@implementation TransferRequest
- (instancetype)initWithTo:(NSString *)to Memo:(NSString *)memo Quantity:(NSString *)quantity Wif:(NSString *)wif PubkeyArray:(NSArray *)keyarray{
    if (self = [super init]) {
        _to = to;
        _quantity = quantity;
        self.transferModel = [[TransferModel alloc]init];
        self.permission = @"active";
        self.wif = wif;
        self.keyArray = [NSArray arrayWithArray:keyarray];
        self.name = @"transfer";
        _memo = memo;
    }
    return self;
}

- (NSString *)requestUrlPath{
    return self.urlStr;
}

- (void)transferToekn{
    //jsontobin
    NSString *code = @"baic.token";
    NSArray *tempArray = [_quantity componentsSeparatedByString:@" "];
    //baic,code = baic  其他 baic.token
    if ([[tempArray lastObject] isEqualToString:@"BAIC"]) {
        code = @"baic";
    }
    
    NSString *action = self.name;
    NSArray *args = @[ACCOUNT_NAME_VALUE,_to,_quantity,_memo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:code forKey:@"code"];
    [param setObject:action forKey:@"action"];
    [param setObject:args forKey:@"args"];
    self.param = param;
    @weakify(self);
    self.urlStr = HTTP_ABI_JSON_TO_BIN;
    [self postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
         TransferModel *model = [[TransferModel alloc]initWithDictionary:data error:nil];
        self.transferModel.binargs = model.binargs;
        
        [self getChainInfo];
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

//获取当前最新区块
- (void)getChainInfo{
    
    self.urlStr = HTTP_CHAIN_GET_INFO;
    self.param = @{};
    
    @weakify(self);
    [self postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
        TransferModel *model = [[TransferModel alloc]initWithDictionary:data error:nil];
        self.transferModel.head_block_num = model.head_block_num;
        self.transferModel.timestamp = model.timestamp;
        self.transferModel.ref_block_prefix = model.ref_block_prefix;
        self.transferModel.chain_id = model.chain_id;
        
        
        [self selectPublicKey];
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];

}

//publickey
- (void)selectPublicKey{
    NSString *time = [[[NSDate dateFromString:self.transferModel.timestamp] dateByAddingTimeInterval:30] formatterToISO8601];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *transacDic = [NSMutableDictionary dictionary];
    [transacDic setObject:self.transferModel.ref_block_prefix forKey:@"ref_block_prefix"];
    [transacDic setObject:self.transferModel.head_block_num forKey:@"ref_block_num"];
    [transacDic setObject:time forKey:@"expiration"];
    
    [transacDic setObject:@[] forKey:@"context_free_data"];
    [transacDic setObject:@[] forKey:@"transaction_extensions"];
    [transacDic setObject:@[] forKey:@"context_free_actions"];
    [transacDic setObject:@0 forKey:@"delay_sec"];
    [transacDic setObject:@0 forKey:@"max_cpu_usage"];
    [transacDic setObject:@0 forKey:@"max_net_usage_words"];
    [transacDic setObject:@0 forKey:@"gas_limit"];
    [transacDic setObject:@"" forKey:@"gas_payer"];
    
    NSMutableDictionary *actionDict = [NSMutableDictionary dictionary];
    [actionDict setObject:@"baic.token" forKey:@"account"];
    [actionDict setObject:@"transfer" forKey:@"name"];
    [actionDict setObject:self.transferModel.binargs forKey:@"data"];
    
    NSMutableDictionary *authorizationDict = [NSMutableDictionary dictionary];
    [authorizationDict setObject:ACCOUNT_NAME_VALUE forKey:@"actor"];
    [authorizationDict setObject:self.permission forKey:@"permission"];
    [actionDict setObject:@[authorizationDict] forKey:@"authorization"];
    [transacDic setObject:@[actionDict] forKey:@"actions"];
    [paramDict setObject:transacDic forKey:@"transaction"];
    [paramDict setObject:self.keyArray forKey:@"available_keys"];
    
    self.urlStr = HTTP_CHAIN_GET_REQUIRED_KEYS;
    self.param = paramDict;
    @weakify(self);
    [self postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
        NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"required_keys"]];
        self.requirePubKey = [array firstObject];
        [self signTransfer];
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];

}

//sign
- (void)signTransfer{
    NSString *time = [[[NSDate dateFromString:self.transferModel.timestamp] dateByAddingTimeInterval:30] formatterToISO8601];
    
    NSMutableDictionary *transacDic = [NSMutableDictionary dictionary];
    [transacDic setObject:self.transferModel.ref_block_prefix forKey:@"ref_block_prefix"];
    [transacDic setObject:self.transferModel.head_block_num forKey:@"ref_block_num"];
    [transacDic setObject:time forKey:@"expiration"];
    [transacDic setObject:@[] forKey:@"context_free_data"];
    [transacDic setObject:@[] forKey:@"signatures"];
    [transacDic setObject:@[] forKey:@"context_free_actions"];
    [transacDic setObject:@0 forKey:@"delay_sec"];
    [transacDic setObject:@0 forKey:@"max_cpu_usage"];
    [transacDic setObject:@0 forKey:@"max_net_usage_words"];
    
    NSMutableDictionary *actionDict = [NSMutableDictionary dictionary];
    
    NSArray *tempArray = [_quantity componentsSeparatedByString:@" "];
    //baic,code = baic  其他 baic.token
    if ([[tempArray lastObject] isEqualToString:@"BAIC"]) {
        [actionDict setObject:@"baic" forKey:@"account"];
    }else{
        [actionDict setObject:@"baic.token" forKey:@"account"];
    }

    [actionDict setObject:@"transfer" forKey:@"name"];
    [actionDict setObject:self.transferModel.binargs forKey:@"data"];
    
    NSMutableDictionary *authorizationDict = [NSMutableDictionary dictionary];
    [authorizationDict setObject:ACCOUNT_NAME_VALUE forKey:@"actor"];
    [authorizationDict setObject:self.permission forKey:@"permission"];
    [actionDict setObject:@[authorizationDict] forKey:@"authorization"];
    [transacDic setObject:@[actionDict] forKey:@"actions"];
    
    NSString *wif = self.wif;
    BAICKey *ssKey = [[BAICKey alloc] initWithWIF:wif];
    
    NSData *chainIDHexData = [NSObject convertHexStrToData:self.transferModel.chain_id];
    Sha256 *sha256 = [[Sha256 alloc] initWithData:[BAICByteWriter getBytesForSignature:chainIDHexData andParams:transacDic andCapacity:255]];
    
    NSString *baicSigStr = [ssKey baicSign:sha256.mHashBytesData];
    NSString *packed_trxHexStr = [[BAICByteWriter getBytesForSignature:nil andParams: transacDic andCapacity:512] hexadecimalString];
    [self pushTransferWithSignatures:baicSigStr Packed_trxHexStr:packed_trxHexStr];
    
}

- (void)pushTransferWithSignatures:(NSString *)signatures Packed_trxHexStr:(NSString *)packed_trxHexStr{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@[signatures] forKey:@"signatures"];
    [param setObject:@"none" forKey:@"compression"];
    [param setObject:@"" forKey:@"packed_context_free_data"];
    [param setObject:packed_trxHexStr forKey:@"packed_trx"];
    
    self.param = param;
    self.urlStr = HTTP_CHAIN_PUSH_TRANSACTION;
    @weakify(self);
    [self postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
        [[UIApplication sharedApplication].keyWindow makeToast:@"success"];
        if (self.success) {
            self.success();
        }
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
@end
