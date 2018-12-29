//
//  BaseCreateInViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "BaseCreateInViewController.h"

@interface BaseCreateInViewController ()

@end

@implementation BaseCreateInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.base_titleLabel = [[UILabel alloc]init];
    [self.view addSubview:self.base_titleLabel];
    self.base_titleLabel.textColor = kBlueColor;
    self.base_titleLabel.font = kUIFontWithMediumSize(kScaleX(32));
    self.base_titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.base_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavigationBarHeight + kScaleX(35));
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
