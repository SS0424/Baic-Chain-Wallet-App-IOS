//
//  UtilsMacro.h
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define kScreenHeight       ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth        ([UIScreen mainScreen].bounds.size.width)

// iPhoneX
#define kStatusBarHeight    ([UIScreen mainScreen].bounds.size.height >= 812 ? 44:20)
#define kSafeHeight         ([UIScreen mainScreen].bounds.size.height >= 812 ? [UIScreen mainScreen].bounds.size.height - 88 - 34:[UIScreen mainScreen].bounds.size.height - 64 )
#define kNavigationBarHeight ([UIScreen mainScreen].bounds.size.height >= 812 ? 88:64)
#define kSafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height >= 812 ? 34:0)

#define kScaleX(number)      ([UIScreen mainScreen].bounds.size.width/375 *(number))
#define kUIColorWithRGB(r, g, b)  [UIColor colorWithRed:  r / 255.f green:  g / 255.f blue:  b / 255.f alpha: 1]
//背景颜色 白色
#define kBgColor             [UIColor colorWithRed:  255 / 255.f green:  255 / 255.f blue:  255 / 255.f alpha: 1]

//rgb 9,141,230
#define kBlueColor            [UIColor colorWithRed:  9 / 255.f green:  141 / 255.f blue:  230 / 255.f alpha: 1]
//黑色
#define kBlackColor          [UIColor colorWithRed:  0 / 255.f green:  0 / 255.f blue:  0 / 255.f alpha: 1]
//字体黑
#define kFontBlackColor      [UIColor colorWithRed:  44 / 255.f green:  65 / 255.f blue:  80 / 255.f alpha: 1]
#define kUIImageNamed(imageName)          [UIImage imageNamed:imageName]
//字体设置
#define kUIFontWithSemiboldSize(f)   ([UIFont fontWithName:@"PingFangSC-Semibold" size:f])
#define kUIFontWithHeavySize(f)      ([UIFont fontWithName:@"PingFang-SC-Heavy" size:f])
#define kUIFontWithMediumSize(f)     ([UIFont fontWithName:@"PingFang-SC-Medium" size:f])
#define kUIFontWithRegularSize(f)    ([UIFont fontWithName:@"PingFangSC-Regular" size:f])
#define kUIFontWithBoldSize(f)       ([UIFont boldSystemFontOfSize:f])
//判断字符串是否为空
#define kIsNULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) ||[string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//存储
#define ACCOUNT_KEY @"account"
#define ACCOUNT_NAME_VALUE  [[NSUserDefaults standardUserDefaults] objectForKey:ACCOUNT_KEY]
//判断字符串是否为空
#define kIsNULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) ||[string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
#endif /* UtilsMacro_h */
