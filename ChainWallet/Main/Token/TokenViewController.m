//
//  TokenViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TokenViewController.h"
#import "TokenTradeTableViewCell.h"
#import <LEEAlert/LEEAlert.h>
#import "UIButton+EnlargeTouchArea.h"
#import "ZXingWrapper.h"
#import "UIImage+AddCategory.h"
#import "AlertViewManager.h"
#import "TransferViewController.h"
@interface TokenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) TokenModel *tokenModel;
@property (strong,nonatomic) UITableView *tokenTable;
//转账
@property (strong,nonatomic) UIButton *tradeBtn;
//收款
@property (strong,nonatomic) UIButton *receiveBtn;
@end

@implementation TokenViewController

- (instancetype)initWithViewControllerTitle:(TokenModel *)model{
    self = [super init];
    if (self) {
        //self.viewTitle = title;
        self.tokenModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
    [self createRAC];
}

- (void)createRAC{

    
    @weakify(self);
    //转账
    //abijsontobin
    [[_tradeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        TransferViewController *view = [[TransferViewController alloc]initWithViewControllerModel:self.tokenModel];
        [self.navigationController pushViewController:view animated:YES];        
    }];
    //收款
    [[_receiveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        //@strongify(self);
        [[[AlertViewManager alloc]init]showQRCodeImageAlert];
    }];
}

- (void)createUI{
    self.base_titleLabel.text = _tokenModel.token;
    [self.view addSubview:self.tokenTable];
    
    _tradeBtn = [[UIButton alloc]init];
    [self.view addSubview:_tradeBtn];
    [_tradeBtn setTitle:NSLocalizedString(@"转账", nil) forState:UIControlStateNormal];
    [_tradeBtn setTitleColor:kUIColorWithRGB(255, 255, 255) forState:UIControlStateNormal];
    _tradeBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    _tradeBtn.layer.cornerRadius = kScaleX(6);
    _tradeBtn.backgroundColor = kUIColorWithRGB(0, 140, 236);
    [_tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight - kScaleX(10));
        //make.size.mas_equalTo(CGSizeMake(kScaleX(170), kScaleX(40)));
        make.right.equalTo(self.view.mas_centerX).offset(-kScaleX(5));
        make.left.equalTo(self.view).offset(kScaleX(10));
        make.height.equalTo(@(kScaleX(40)));
    }];
    
    _receiveBtn = [[UIButton alloc]init];
    [self.view addSubview:_receiveBtn];
    [_receiveBtn setTitle:NSLocalizedString(@"收款", nil) forState:UIControlStateNormal];
    [_receiveBtn setTitleColor:kUIColorWithRGB(255, 255, 255) forState:UIControlStateNormal];
    _receiveBtn.titleLabel.font = kUIFontWithMediumSize(kScaleX(16));
    _receiveBtn.layer.cornerRadius = kScaleX(6);
    _receiveBtn.backgroundColor = kUIColorWithRGB(13, 189, 212);
    [_receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight - kScaleX(10));
        //make.size.mas_equalTo(CGSizeMake(kScaleX(170), kScaleX(40)));
        make.left.equalTo(self.view.mas_centerX).offset(kScaleX(5));
        make.right.equalTo(self.view).offset(-kScaleX(10));
        make.height.equalTo(@(kScaleX(40)));
    }];
}

- (UITableView *)tokenTable{
    if (!_tokenTable) {
        _tokenTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kSafeHeight - kScaleX(60)) style:UITableViewStylePlain];
        _tokenTable.dataSource = self;
        _tokenTable.delegate = self;
        _tokenTable.separatorInset = UIEdgeInsetsMake(0, kScaleX(30), 0, kScaleX(30));
        _tokenTable.separatorColor = kUIColorWithRGB(240, 243, 244);
        [_tokenTable registerClass:[TokenTradeTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tokenTable;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleX(63);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TokenTradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    
#warning debug by zcw
    /*
    if (indexPath.row %2 == 0) {
        cell.stateImgView.image = kUIImageNamed(@"image_token_out");
        cell.countLabel.text = @"-10.00";
    }else{
        cell.stateImgView.image = kUIImageNamed(@"image_token_in");
        cell.countLabel.text = @"+10.00";
    }
     */
    cell.tokenNameLabel.text = _tokenModel.token;
    cell.countLabel.text = _tokenModel.count;

    //cell.timelabel.text = @"2018-10-10 10:10:10";
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
/*
- (void)showReceiveAlert{
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(315), kScaleX(342))];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(315), kScaleX(82))];
    topView.backgroundColor = kBlueColor;
    [contentView addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [topView addSubview:titleLabel];
    titleLabel.textColor = kUIColorWithRGB(255, 255, 255);
    titleLabel.font = kUIFontWithMediumSize(kScaleX(18));
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(topView).offset(kScaleX(14));
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [topView addSubview:closeBtn];
    [closeBtn setImage:kUIImageNamed(@"btn_alert_close") forState:UIControlStateNormal];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(topView).offset(kScaleX(-18));
    }];
    [closeBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 关闭当前显示的Alert或ActionSheet
        [LEEAlert closeWithCompletionBlock:^{
            //如果在关闭后需要做一些其他操作 建议在该Block中进行
        }];
    }];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    [topView addSubview:addressLabel];
    addressLabel.textColor = kUIColorWithRGB(255, 255, 255);
    addressLabel.font = kUIFontWithRegularSize(kScaleX(12));
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.width.equalTo(@(kScaleX(160)));
        make.top.equalTo(titleLabel.mas_bottom).offset(kScaleX(10));
    }];

    UIButton *ccopyBtn = [[UIButton alloc]init];
    [topView addSubview:ccopyBtn];
    [ccopyBtn setImage:kUIImageNamed(@"btn_hone_copy") forState:UIControlStateNormal];
    [ccopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLabel);
        make.left.equalTo(addressLabel.mas_right).offset(kScaleX(10));
    }];
    [ccopyBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
    [[ccopyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
    }];
    
    UIImageView *qrImgView = [[UIImageView alloc]init];
    [contentView addSubview:qrImgView];
    [qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kScaleX(140), kScaleX(140)));
        make.bottom.equalTo(contentView).offset(kScaleX(-60));
    }];
    UIImage *qrImage = [UIImage createQRImageWithString:@"我是一个测试数据" AndSize:CGSizeMake(kScaleX(140), kScaleX(140))];
    //DLog(@"qrImage = %@",qrImage);
    qrImgView.image = qrImage;

#warning debug by zcw
    titleLabel.text = @"BAIC-001";
    addressLabel.text = @"ASDFASFDASDFASDFASFASDFASFDADASDFADSasfasasdf";
    
    [LEEAlert alert].config.LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = contentView;
        custom.isAutoWidth = NO;
    }).LeeClickBackgroundClose(YES)
    .LeeBackGroundColor(kUIColorWithRGB(31, 39, 55))
    .LeeBackgroundStyleTranslucent(0.9f)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeMaxWidth(kScaleX(315))
    .LeeMaxHeight(kScaleX(342))
    .LeeShow();
}
*/
@end
