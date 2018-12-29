//
//  ScanViewController.h
//  ChainWallet
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <LBXScanViewController.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ScanBlock)(NSString *address);
@interface ScanViewController : LBXScanViewController
@property (copy,nonatomic) ScanBlock success;
@end

NS_ASSUME_NONNULL_END
