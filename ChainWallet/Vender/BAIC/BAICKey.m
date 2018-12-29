//
//  BAICKey.m
//  ChainWallet
//
//  Created by SSSSSS on 2018/12/13.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BAICKey.h"
#import "BTCAddress.h"
@implementation BAICKey

- (instancetype)initWithWIF:(NSString *)wifString{
   
    NSLog(@"%ld",BTCDataFromBase58(wifString).length);
    
    NSLog(@"%@",BTCBase58StringWithData(BTCDataFromBase58(wifString)));
    NSData *sss = [BTCDataFromBase58(wifString) subdataWithRange:NSMakeRange(1,BTCDataFromBase58(wifString).length - 5)];
    _btcKey = [[BTCKey alloc] initWithPrivateKey:sss];
    if (self = [super initWithWIF:wifString]) {
    }
    NSLog(@"%@",self.publicKey);
    return self;
}


- (NSString*)publicKey {
    
    NSMutableData *pub = [NSMutableData new];
    [pub appendData:_btcKey.compressedPublicKey];
    [pub appendData:[((NSData *)BTCRIPEMD160(_btcKey.compressedPublicKey)) subdataWithRange:NSMakeRange(0, 4)]];
    NSMutableString *address = [NSMutableString new];
    [address appendString:@"BAIC"];
    [address appendString:BTCBase58StringWithData(pub)];
    return address;
}


- (NSString *)wif{
    return _btcKey.WIF;
}

- (NSString *)baicSign:(NSData *)hash{
    NSString *signatureStr = [NSString stringWithFormat:@"SIG_K1_%@", BTCBase58StringWithData([_btcKey baicCompactSignatureForHash:hash])];
    return signatureStr;
}

- (NSData *)eossign:(NSData *)hash{
    
    return [_btcKey eosCompactSignatureForHash:hash];
}

@end
