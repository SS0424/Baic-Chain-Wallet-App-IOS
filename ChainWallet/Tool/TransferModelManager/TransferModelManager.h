//
//  TransferModelManager.h
//  ChainWallet
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TransferModelManager : NSObject
+ (TransferModelManager *)sharedManager;

@property (strong,nonatomic) TransferModel *transferModel;

- (NSString *)stringAddTimeMin;

- (NSString *)stringFromDate:(NSDate *)date;
- (NSString *)dateFromString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
