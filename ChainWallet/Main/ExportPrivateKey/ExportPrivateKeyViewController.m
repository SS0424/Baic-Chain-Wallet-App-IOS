//
//  ExportPrivateKeyViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "ExportPrivateKeyViewController.h"
#import "ExportPrivateKeyTableViewCell.h"
#import "AccountInfoModel.h"
#import "ExportPrivateKeyModel.h"
#import "AESCrypt.h"
@interface ExportPrivateKeyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) UITableView *privateTable;
@end

@implementation ExportPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.base_titleLabel.text = NSLocalizedString(@"导出私钥", nil);
    [self createUI];
}

- (void)createUI{
    
    //_pwd = @"123";
    
    NSArray *array = [AccountManager sharedManager].current_account_info;
    AccountInfoModel *info = [array firstObject];
    DLog(@"info = %@",info);

    NSDictionary *dict1 = @{@"account_name":info.account_name,
                            @"perm_name":@"owner",
                            @"account_private_key":[AESCrypt decrypt:info.owner_privatekey password:_pwd],
                            @"account_public_key":[AESCrypt decrypt:info.owner_publickey password:_pwd]
                            };
    ExportPrivateKeyModel *model1 = [[ExportPrivateKeyModel alloc]initWithDictionary:dict1 error:nil];
    
    NSDictionary *dict2 = @{@"account_name":info.account_name,
                            @"perm_name":@"active",
                            @"account_private_key":[AESCrypt decrypt:info.active_privatekey password:_pwd],
                            @"account_public_key":[AESCrypt decrypt:info.active_publickey password:_pwd]
                            };
    ExportPrivateKeyModel *model2 = [[ExportPrivateKeyModel alloc]initWithDictionary:dict2 error:nil];
    
    _dataSource = [NSMutableArray array];
    [_dataSource addObject:model1];
    [_dataSource addObject:model2];
    [self.view addSubview:self.privateTable];
}

- (UITableView *)privateTable{
    if (!_privateTable) {
        _privateTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kSafeHeight) style:UITableViewStylePlain];
        _privateTable.dataSource = self;
        _privateTable.delegate = self;
        _privateTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _privateTable.estimatedRowHeight = kScaleX(180);
        [_privateTable registerClass:[ExportPrivateKeyTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _privateTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExportPrivateKeyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.infoModel = _dataSource[indexPath.row];
    return cell;
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
