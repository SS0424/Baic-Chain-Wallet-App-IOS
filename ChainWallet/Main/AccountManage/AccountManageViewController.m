//
//  AccountManageViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "AccountManageViewController.h"
#import "WalletPopView.h"
#import "AccountInfoModel.h"
#import "AESCrypt.h"
#import "ExportPrivateKeyViewController.h"

@interface AccountManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *manageTable;
@property (strong,nonatomic) NSArray *dataSource;
@end

@implementation AccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kUIColorWithRGB(242, 243, 244);
    self.base_titleLabel.text = NSLocalizedString(@"账号管理", nil);
    [self createUI];
}

- (void)createUI{
    _dataSource = @[[AccountManager sharedManager].current_account_name,NSLocalizedString(@"资源管理", nil),NSLocalizedString(@"导出私钥", nil)];
    [self.view addSubview:self.manageTable];
}

- (UITableView *)manageTable{
    if (!_manageTable) {
        _manageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kSafeHeight) style:UITableViewStyleGrouped];
        _manageTable.delegate = self;
        _manageTable.dataSource = self;
        _manageTable.separatorColor = kUIColorWithRGB(242, 243, 244);
        _manageTable.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _manageTable;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleX(46);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScaleX(10);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = kFontBlackColor;
    cell.textLabel.font = kUIFontWithMediumSize(kScaleX(16));
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIViewController *view = [NSClassFromString(@"AccountExchangeViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 1){
        UIViewController *view = [NSClassFromString(@"ResourceManageViewController") new];
        [self.navigationController pushViewController:view animated:YES];
    }else if (indexPath.row == 2){
        //UIViewController *view = [NSClassFromString(@"ExportPrivateKeyViewController") new];
        //[self.navigationController pushViewController:view animated:YES];
        
        WalletPopView *popView = [[WalletPopView alloc]initWithType:WalletPopViewTypePayPassword BackgroundView:self.view WithDataDictionary:nil];
        @weakify(self);
        popView.commitBlock = ^(NSString * _Nonnull pwd) {
            if (pwd.length == 0) {
                return ;
            }
            @strongify(self);
            [self pwdVerify:pwd];
        };
        
    }else{
        
    }
}

- (void)pwdVerify:(NSString *)pwd{
    NSArray *array = [[AccountManager sharedManager]current_account_info];
    AccountInfoModel *model =[array firstObject];
    NSString *acwif = [AESCrypt decrypt:model.active_privatekey password:pwd];
    //NSString *countStr = [NSString stringWithFormat:@"%.9f",[_sumTextField.text doubleValue]];
    //NSString *quantity = [NSString stringWithFormat:@"%@ %@",countStr,_tokenModel.token];
    //NSMutableArray *keyArray = [NSMutableArray array];
    //[keyArray addObject:[AESCrypt decrypt:model.active_publickey password:pwd]];
    //[keyArray addObject:[AESCrypt decrypt:model.owner_publickey password:pwd]];
    
    if (acwif.length > 0 && acwif != nil) {
        ExportPrivateKeyViewController *view = [[ExportPrivateKeyViewController alloc]init];
        view.pwd = pwd;
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
