//
//  NumsFieldView.m
//  WalletiOS
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 BAIC. All rights reserved.
//

#import "NumsFieldView.h"

@interface NumsFieldView()<UITextFieldDelegate>
{
    CGFloat _width;     // 控件自身的宽
    CGFloat _height;    // 控件自身的高
}
@property(strong,nonatomic) NSMutableArray *textArray;
@end

@implementation NumsFieldView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        //设置默认
        [self setDefault];
        [self setupUI];
        //if(CGRectIsEmpty(frame)) {self.frame = CGRectMake(0, 0, 110, 30);};
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame AndFieldsCount:(NSInteger)count{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        //设置默认
        //[self setDefault];
        _numCount = count;
        self.textArray = [[NSMutableArray alloc]init];
        
        [self setupUI];
        //if(CGRectIsEmpty(frame)) {self.frame = CGRectMake(0, 0, 110, 30);};
    }
    return self;
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _width =  self.frame.size.width;
    _height = self.frame.size.height;
    
    //DLog(@"_width = %f",_width);
    //DLog(@"_height = %f",_height);
    
    CGFloat leading = (_width - _height * _numCount) / (_numCount - 1);
    //width足够，中间留有间距
    if (leading > 0) {
        for (int i = 0; i < _textArray.count; i++) {
            UITextField *textField = (UITextField *)_textArray[i];
            textField.frame = CGRectMake(i * (leading + _height), 0,_height, _height);
        }
    }
    else{
        //leading不够，缩小view,默认设为5,获得高度
        CGFloat viewHeight = (_width - 5 * (_numCount - 1)) / _numCount;
        leading = 5;
        for (int i = 0; i < _textArray.count; i++) {
            UITextField *textField = (UITextField *)_textArray[i];
            textField.frame = CGRectMake(i * (leading + viewHeight), 0,viewHeight, viewHeight);
        }
    }
    _numTextField.frame = CGRectMake(0, 0, _width, _height);
}

-(void)setDefault{
    _numCount = 6;
    self.textArray = [[NSMutableArray alloc]init];
}
-(void)setupUI
{
    
    for (int i = 0; i < _numCount; i++) {
        NumsBaseTextField *textField = [[NumsBaseTextField alloc]init];
        [self addSubview:textField];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = kUIColorWithRGB(66, 85, 99);
        textField.font = kUIFontWithSemiboldSize(18);
        textField.enabled = NO;
        textField.secureTextEntry = YES;
        textField.layer.cornerRadius = 5;
        textField.backgroundColor = kUIColorWithRGB(239, 239, 244);
        [_textArray addObject:textField];
    }
    
    self.numTextField = [[NumsBaseTextField alloc]init];
    [self addSubview:self.numTextField];
    
    _numTextField.keyboardType = UIKeyboardTypeNumberPad;
    _numTextField.textColor = [UIColor clearColor];
    _numTextField.backgroundColor = [UIColor clearColor];
    _numTextField.delegate = self;
    _numTextField.tintColor =[UIColor clearColor];
    [_numTextField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= _numCount) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    else{
        return YES;
    }
}

- (void)textFieldValueChanged:(UITextField *)textField{
    for (int i = 0; i < self.textArray.count; i++) {
        UILabel *label = (UILabel *)self.textArray[i];
        label.text = @"";
    }
    
    for (int i = 0; i<textField.text.length; i++) {
        unichar cha = [textField.text characterAtIndex:i];
        UILabel *label = (UILabel *)self.textArray[i];
        label.text = [NSString stringWithFormat:@"%c",cha];
    }
    
    //输入完毕
    if (textField.text.length == _numCount) {
        if ([self.delegate respondsToSelector:@selector(numsFieldViewDidFinished:)]) {
            [self.delegate numsFieldViewDidFinished:textField.text];
        }
        
        if ([self.delegate respondsToSelector:@selector(numsFiedldViewWith:Finished:)]) {
            [self.delegate numsFiedldViewWith:self Finished:textField.text];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(numsFieldViewDidEditing:)]) {
            [self.delegate numsFieldViewDidEditing:textField.text];
        }
        
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    for (UITextField *textfield in _textArray) {
        textfield.secureTextEntry = _secureTextEntry;
    }
}

- (void)setIsErrorVisable:(BOOL)isErrorVisable{
    _isErrorVisable = isErrorVisable;
    for (UITextField *textfield in _textArray) {
        //textfield.layer.borderColor = kColor(255, 83, 109, 1).CGColor;
        textfield.layer.borderColor = kUIColorWithRGB(255, 83, 109).CGColor;
        textfield.layer.borderWidth = isErrorVisable;
    }
}

- (void)setNumCount:(NSInteger)numCount{
    _numCount = numCount;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
