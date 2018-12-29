//
//  BAICKey.h
//  ChainWallet
//
//  Created by SSSSSS on 2018/12/13.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BTCKey.h"
#import "BTCData.h"
#import "BTCBase58.h"

NS_ASSUME_NONNULL_BEGIN

@interface BAICKey : BTCKey

@property(nonatomic,copy) NSString *publicKey;
@property(nonatomic,copy) NSString *wif;
@property(nonatomic,strong) BTCKey *btcKey;
- (NSString *)baicSign:(NSData *)hash;
- (NSData *)eossign:(NSData *)hash;

@end

NS_ASSUME_NONNULL_END
