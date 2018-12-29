//
//  ScanViewController.m
//  ChainWallet
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "ScanViewController.h"
#import "UIButton+EnlargeTouchArea.h"


@interface ScanViewController ()
@property(strong,nonatomic) UILabel *base_titleLabel;
@property(strong,nonatomic) UIView *base_navView;
@property(strong,nonatomic) UIButton *base_returnBtn;
@end

@implementation ScanViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cameraInvokeMsg = @"相机启动中";
    //self.style
    self.style = [self recoCropRect];
    self.isOpenInterestRect = YES;
    self.libraryType = SLT_ZXing;
    self.scanCodeType = SCT_QRCode;
    self.view.backgroundColor = [UIColor blackColor];
    [self setNavigationbar];
}

- (void)setNavigationbar{
    _base_returnBtn = [[UIButton alloc]init];
    [_base_returnBtn setImage:[UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    [_base_returnBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [_base_returnBtn addTarget:self action:@selector(base_customPopNavigationController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:_base_returnBtn];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kUIColorWithRGB(67, 86, 99),NSFontAttributeName :kUIFontWithMediumSize(kScaleX(18))}];
    self.navigationItem.title = NSLocalizedString(@"扫码", nil);
}

- (void)base_customPopNavigationController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (LBXScanViewStyle*)recoCropRect{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 80;
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    style.animationImage = imgPartNet;
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    return style;
}


#pragma mark -实现类继承该方法，作出对应处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array{
    if (!array ||  array.count < 1){
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult{
    if (!strResult) {
        strResult = @"识别失败";
    }
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult{
    NSLog(@"strResult = %@",strResult);
    if (self.success) {
        self.success(strResult.strScanned);
    }
    
//    ScanResultViewController *vc = [ScanResultViewController new];
//    vc.imgScan = strResult.imgScanned;
//
//    vc.strScan = strResult.strScanned;
//
//    vc.strCodeType = strResult.strBarCodeType;
//
//    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
