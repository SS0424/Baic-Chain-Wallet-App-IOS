//
//  UrlMacro.h
//  ChainWallet
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018 zcw. All rights reserved.
//

#ifndef UrlMacro_h
#define UrlMacro_h

#define HTTP_HOST   @"http:chain.baic.io"
#define HTTP_PORT   @"20188"
#define HTTP_VERSION   @"v1"
#define HTTP(apiUrl) [NSString stringWithFormat:@"%@:%@/%@/%@",HTTP_HOST,HTTP_PORT,HTTP_VERSION,apiUrl]

//获取账号信息
#define HTTP_CHAIN_GET_ACCOUNT  HTTP(@"chain/get_account")

//查询余额
#define HTTP_GET_CURRENCY_BALANCE  HTTP(@"chain/get_currency_balance")

//将交易信息由JSON格式序列化为BIN格式字符串
#define HTTP_ABI_JSON_TO_BIN    HTTP(@"chain/abi_json_to_bin")

//获取当前最新的区块编号
#define HTTP_CHAIN_GET_INFO     HTTP(@"chain/get_info")

//根据区块编号获取区块详情
#define HTTP_CHAIN_GET_BLOCK      HTTP(@"chain/get_block")

//筛选出签署交易需要的公钥
#define HTTP_CHAIN_GET_REQUIRED_KEYS    HTTP(@"chain/get_required_keys")

//签署交易
#define HTTP_WALLET_SIGN_TRANSACTION    HTTP(@"wallet_sign_trx/sign_transaction")

//提交交易
#define HTTP_CHAIN_PUSH_TRANSACTION HTTP(@"chain/push_transaction")

#endif /* UrlMacro_h */
