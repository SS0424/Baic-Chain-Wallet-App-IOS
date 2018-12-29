//
//  UIImage+AddCategory.h
//  ChainWallet
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AddCategory)
+ (UIImage *)createQRImageWithString:(NSString *)dataString AndSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
