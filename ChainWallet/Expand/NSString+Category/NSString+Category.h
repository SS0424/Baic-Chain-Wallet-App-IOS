//
//  NSString+Category.h
//  ChainWallet
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)
+(NSString *)base64EncodeString:(NSString *)string;
+(NSString *)base64DecodeString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
