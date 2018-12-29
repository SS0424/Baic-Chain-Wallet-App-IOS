//
//  BAICByteWriter.h
//  ChainWallet
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Extension.h"
NS_ASSUME_NONNULL_BEGIN

@interface BAICByteWriter : NSObject
- (instancetype)initWithCapacity:(int) capacity ;

- (void)ensureCapacity:(int)capacity ;

- (void)put:(Byte)b ;

- (void)putShortLE:(short)value ;

- (void)putIntLE:(int)value ;

- (void)putLongLE:(long)value ;

- (void)putBytes:(NSData *)value ;

- (NSData *)toBytes ;

- (int)length ;

- (void)putString:(NSString *)value ;

- (void)putCollection:(NSArray *)collection ;

- (void)putVariableUInt:(long)val ;


+ (NSData *)getBytesForSignature:(NSData *)chainId andParams:(NSDictionary *)paramsDic andCapacity:(int)capacity;


@end

NS_ASSUME_NONNULL_END
