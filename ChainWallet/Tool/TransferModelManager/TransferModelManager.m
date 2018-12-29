//
//  TransferModelManager.m
//  ChainWallet
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TransferModelManager.h"
#import "NSDate+JKUtilities.h"

static TransferModelManager *manager = nil;
@implementation TransferModelManager
+ (TransferModelManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TransferModelManager alloc]init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.transferModel = [[TransferModel alloc]init];
    }
    return self;
}

//NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date
{
    //获取系统当前时间
    //NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}

//NSString转nssting
- (NSString *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    //NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSString *s = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:s];
    
    NSDate *addDate = [[NSDate date]jk_dateByAddingMinutes:1];
    
    NSString *s1 = [self stringFromDate:addDate];
    
    DLog(@"s1 = %@",s1);
    return s1;
    //return date;
}

@end
