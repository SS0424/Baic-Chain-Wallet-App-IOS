//
//  NumsFieldView.h
//  WalletiOS
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 BAIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumsBaseTextField.h"

@class NumsFieldView;
@protocol NumsFieldViewDelegate<NSObject>
@optional
- (void)numsFieldViewDidEditing:(NSString *)text;
- (void)numsFieldViewDidFinished:(NSString *)text;
- (void)numsFiedldViewWith:(NumsFieldView *)numView Finished:(NSString *)text;
@end

@interface NumsFieldView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndFieldsCount:(NSInteger)count;
- (instancetype)initWithFrame:(CGRect)frame;
//textfield
@property(strong,nonatomic) NumsBaseTextField *numTextField;
/** 数字模块数量*/
@property(assign,nonatomic) BOOL secureTextEntry;
@property(assign,nonatomic) BOOL isErrorVisable;
@property(assign,nonatomic) NSInteger numCount;
@property(weak,nonatomic) id<NumsFieldViewDelegate>delegate;
@end
