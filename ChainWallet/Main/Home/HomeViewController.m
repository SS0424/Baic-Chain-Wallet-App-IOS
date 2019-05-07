//
//  HomeViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "HomeViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "HomeAssetTableViewCell.h"
#import "HomeTokenTableViewCell.h"
#import "TokenViewController.h"
#import "ScanViewController.h"
#import "UIImage+AddCategory.h"
#import <LEEAlert/LEEAlert.h>
#import "AlertViewManager.h"
#import "GetBalanceRequest.h"
#import "TransferViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *homeTable;
@property (strong,nonatomic) UIView *navView;
@property (strong,nonatomic) UIView *statusBarView;
@property (strong,nonatomic) UIButton *leftNavBtn;
@property (strong,nonatomic) UIButton *rightNavBtn;

@property (nonatomic, assign)BOOL isCanUseSideBack;  // 手势是否启动

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavView];

    [self createTB];
    
    [self createRAC];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createDadaSource];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startSideBack];
}
 
/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}
/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}
- (void)createDadaSource{
    @weakify(self);
    GetBalanceRequest *request = [[GetBalanceRequest alloc]initWithCode:@"baic.token" Account:ACCOUNT_NAME_VALUE Symbol:@[@"DUSD",@"BAIC"]];
    
    [request didloadBalanceDataSourceResultSuccess:^{
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [self.homeTable reloadData];
        });
    } failure:^{
        
    }];
}

- (void)createRAC{
    @weakify(self);
    [[_leftNavBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [[[AlertViewManager alloc]init]showQRCodeImageAlert];
    }];
    
    [[_rightNavBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        ScanViewController *scan = [[ScanViewController alloc]init];
        [self.navigationController pushViewController:scan animated:YES];
        @weakify(self);
        scan.success = ^(NSString * _Nonnull address) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            [self scanresult:address];
        };
    }];
}

- (void)scanresult:(NSString *)address{
    if ([address hasPrefix:@"BAICCHAIN:"]) {
        TransferViewController *view = [[TransferViewController alloc] initWithViewControllerModel:[AccountManager sharedManager].tokenArray[2]];
        view.address = [address stringByReplacingOccurrencesOfString:@"BAICCHAIN:" withString:@""];
        [self.navigationController pushViewController:view animated:YES];;
    }

}
- (void)createNavView{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    _statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight)];
    [self.view addSubview:_statusBarView];
    _statusBarView.backgroundColor = kBgColor;
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight - kStatusBarHeight)];
    [self.view addSubview:_navView];
    _navView.backgroundColor = kBgColor;
    
    _leftNavBtn = [[UIButton alloc]init];
    [_navView addSubview:_leftNavBtn];
    [_leftNavBtn setImage:kUIImageNamed(@"nav_qrcode") forState:UIControlStateNormal];
    [_leftNavBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navView).offset(kScaleX(30));
        make.centerY.equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    _rightNavBtn = [[UIButton alloc]init];
    [_navView addSubview:_rightNavBtn];
    [_rightNavBtn setImage:kUIImageNamed(@"nav_scan") forState:UIControlStateNormal];
    [_rightNavBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navView).offset(-kScaleX(30));
        make.centerY.equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
}

- (void)createTB{
    [self.view addSubview:self.homeTable];
}

- (UITableView *)homeTable{
    if (!_homeTable) {
        _homeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _homeTable.delegate = self;
        _homeTable.dataSource = self;
        _homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTable.contentInset = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight, 0);
        _homeTable.backgroundColor = kBgColor;
        
        [_homeTable registerClass:[HomeTokenTableViewCell class] forCellReuseIdentifier:@"token"];
        [_homeTable registerClass:[HomeAssetTableViewCell class] forCellReuseIdentifier:@"asset"];

    }
    return _homeTable;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return [AccountManager sharedManager].tokenArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return kScaleX(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kScaleX(145);
    }else{
        return kScaleX(63);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (!view) {
            view = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScaleX(30), 0, kScreenWidth - kScaleX(30), 40)];
        label.text = NSLocalizedString(@"资产", nil);
        label.textColor = kFontBlackColor;
        label.font = kUIFontWithMediumSize(kScaleX(18));
        [view addSubview:label];
        
        return view;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomeAssetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asset"];
        
        cell.chainNameLabel.text = [AccountManager sharedManager].current_account_name;
        
        @weakify(self);
        //账号管理
        [[[cell.morebtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:[cell rac_prepareForReuseSignal]] subscribeNext:^(id x) {
            @strongify(self);
            UIViewController *view = [NSClassFromString(@"AccountManageViewController") new];
            [self.navigationController pushViewController:view animated:YES];
        }];
        
        return cell;
    }else{
        HomeTokenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"token"];
        cell.model = [AccountManager sharedManager].tokenArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        TokenModel *model = [AccountManager sharedManager].tokenArray[indexPath.row];
        TokenViewController *token = [[TokenViewController alloc]initWithViewControllerTitle:model];
        [self.navigationController pushViewController:token animated:YES];
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
