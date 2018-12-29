//
//  NumsBaseTextField.m
//  NowWallet
//
//  Created by apple on 2018/7/12.
//  Copyright © 2018年 zcw. All rights reserved.
//

#import "NumsBaseTextField.h"

@implementation NumsBaseTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//禁止弹框
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
