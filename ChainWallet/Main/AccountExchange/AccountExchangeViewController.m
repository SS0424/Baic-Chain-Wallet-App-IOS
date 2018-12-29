//
//  AccountExchangeViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AccountExchangeViewController.h"
#import "InPrivateKeyViewController.h"

@interface AccountExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *exchangeTable;
@property (strong,nonatomic) NSArray *dataSource;
@end

@implementation AccountExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kUIColorWithRGB(242, 243, 244);

    self.base_titleLabel.text = NSLocalizedString(@"账号切换", nil);
    [self createUI];
}

- (void)createUI{
    _dataSource = [AccountManager sharedManager].account_nameArray;
    [self.view addSubview:self.exchangeTable];
}

- (UITableView *)exchangeTable{
    if (!_exchangeTable) {
        _exchangeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kSafeHeight) style:UITableViewStyleGrouped];
        _exchangeTable.delegate = self;
        _exchangeTable.dataSource = self;
        _exchangeTable.separatorColor = kUIColorWithRGB(242, 243, 244);
        _exchangeTable.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _exchangeTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleX(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return kScaleX(10);
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = _dataSource[indexPath.row];
        cell.textLabel.textColor = kFontBlackColor;
        cell.textLabel.font = kUIFontWithMediumSize(kScaleX(16));
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
        }
        cell.textLabel.text = NSLocalizedString(@"导入私钥", nil);
        cell.textLabel.textColor = kBlueColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = kUIFontWithSemiboldSize(kScaleX(18));
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        
        NSString *accountName = _dataSource[indexPath.row];
        if (![ACCOUNT_NAME_VALUE isEqualToString:accountName]) {
            [[NSUserDefaults standardUserDefaults]setObject:accountName forKey:ACCOUNT_KEY];
            [[AccountManager sharedManager] changeRootViewController];
        }
        
    }else{
        UIViewController *view = [NSClassFromString(@"InPrivateKeyViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }
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
