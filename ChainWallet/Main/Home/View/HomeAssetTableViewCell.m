//
//  HomeAssetTableViewCell.m
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "HomeAssetTableViewCell.h"
#import "UIButton+EnlargeTouchArea.h"
@implementation HomeAssetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBgColor;
        
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = kBlueColor;
        bgView.layer.cornerRadius = kScaleX(10);
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kScaleX(315), kScaleX(109)));
            //make.edges.mas_equalTo(UIEdgeInsetsMake(kScaleX(18), kScaleX(30), kScaleX(9), kScaleX(30)));
            //make.top.equalTo(self.contentView).offset(kScaleX(9));
            //make.bottom.equalTo(self.contentView).offset(-kScaleX(9));
        }];
        
        self.chainNameLabel = [[UILabel alloc]init];
        [bgView addSubview:self.chainNameLabel];
        _chainNameLabel.textColor = kBgColor;
        _chainNameLabel.font = kUIFontWithMediumSize(kScaleX(18));
        [_chainNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(kScaleX(16));
            make.top.equalTo(bgView).offset(kScaleX(11));
        }];
        
        self.addressLabel = [[UILabel alloc]init];
        [bgView addSubview:self.addressLabel];
        _addressLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _addressLabel.textColor = kBgColor;
        _addressLabel.font = kUIFontWithRegularSize(kScaleX(12));
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chainNameLabel.mas_bottom);
            make.left.equalTo(bgView).offset(kScaleX(16));
            make.width.equalTo(@(kScaleX(153)));
        }];
        
        /*
        self.ccopyBtn = [[UIButton alloc]init];
        [bgView addSubview:self.ccopyBtn];
        //_ccopyBtn.backgroundColor = kFontBlackColor;
        [_ccopyBtn setImage:kUIImageNamed(@"btn_hone_copy") forState:UIControlStateNormal];
        [_ccopyBtn setEnlargeEdgeWithTop:kScaleX(8) right:kScaleX(8) bottom:kScaleX(8) left:kScaleX(8)];
        [_ccopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.addressLabel);
            make.left.equalTo(self.addressLabel.mas_right).offset(kScaleX(8));
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        */
        
        self.morebtn = [[UIButton alloc]init];
        [bgView addSubview:self.morebtn];
        [_morebtn setImage:kUIImageNamed(@"btn_home_more") forState:UIControlStateNormal];
        [_morebtn setEnlargeEdgeWithTop:kScaleX(8) right:kScaleX(8) bottom:kScaleX(8) left:kScaleX(8)];
        [_morebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.chainNameLabel);
            make.right.equalTo(bgView).offset(-kScaleX(16));
            make.size.mas_equalTo(CGSizeMake(17, 17));
        }];

        self.assetLabel = [[UILabel alloc]init];
        [bgView addSubview:self.assetLabel];
        _assetLabel.textColor = kBgColor;
        _assetLabel.font = kUIFontWithMediumSize(kScaleX(18));
        _assetLabel.textAlignment = NSTextAlignmentRight;
        [_assetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).offset(-kScaleX(16));
            make.bottom.equalTo(bgView).offset(-kScaleX(10));
        }];
        
#warning debug by zcw
        
        /*
        [[_ccopyBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
            pastboard.string = [AccountManager sharedManager].current_baicPublicKey;
            
            [CSToastManager setQueueEnabled:YES];
            UIView *window = [UIApplication sharedApplication].keyWindow;
            //[window makeToast:@"copy success" duration:2.0 position:];
            [window makeToast:@"copy success" duration:2 position:CSToastPositionCenter];
        }];
         */
        //_assetLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",@"20.00"];
    }
    return self;
}
@end
