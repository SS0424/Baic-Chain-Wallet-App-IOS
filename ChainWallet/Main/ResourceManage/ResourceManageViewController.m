//
//  ResourceManageViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "ResourceManageViewController.h"
#import "ResourceManagerModel.h"
#import "GetAccoutRequest.h"

@interface ResourceManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *resourceTable;
@property (strong,nonatomic) NSArray *dataSource;
@end

@implementation ResourceManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kUIColorWithRGB(242, 243, 244);
    self.base_titleLabel.text = NSLocalizedString(@"资源管理", nil);
    [self createUI];
}

- (void)createUI{
    
    @weakify(self);
    [[[GetAccoutRequest alloc]initWithAccountName:ACCOUNT_NAME_VALUE] postDataSuccess:^(id  _Nonnull data) {
        @strongify(self);
        ResourceManagerModel *model = [[ResourceManagerModel alloc]initWithDictionary:data error:nil];
        NSString *ram = [NSString stringWithFormat:@"%.2f KB/%.2f KB",model.ram_usage/1024.0,model.ram_quota/1024.0];
        NSString *cpu = [NSString stringWithFormat:@"%.2f MS/%.2f SEC",model.used/1000.0,model.max/1000000.0];
        self.dataSource = @[NSLocalizedString(@"内存", nil),NSLocalizedString(@"CPU", nil),ram,cpu];
        [self.view addSubview:self.resourceTable];
    } failure:^(id  _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (UITableView *)resourceTable{
    if (!_resourceTable) {
        _resourceTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kSafeHeight) style:UITableViewStyleGrouped];
        _resourceTable.delegate = self;
        _resourceTable.dataSource = self;
        _resourceTable.separatorColor = kUIColorWithRGB(242, 243, 244);
        _resourceTable.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _resourceTable;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleX(46);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScaleX(10);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = kFontBlackColor;
    cell.textLabel.font = kUIFontWithMediumSize(kScaleX(16));
    
    cell.detailTextLabel.text = _dataSource[indexPath.row + 2];
    cell.detailTextLabel.font = kUIFontWithMediumSize(kScaleX(12));
    cell.detailTextLabel.textColor = kFontBlackColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
