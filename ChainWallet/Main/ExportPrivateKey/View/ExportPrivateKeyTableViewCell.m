//
//  ExportPrivateKeyTableViewCell.m
//  ChainWallet
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "ExportPrivateKeyTableViewCell.h"
#import "NSAttributedString+YYText.h"
#import "UIButton+EnlargeTouchArea.h"
@implementation ExportPrivateKeyTableViewCell

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
        //self.contentView.layer.cornerRadius = kScaleX(6);
        
        UIView *boardView = [[UIView alloc]init];
        [self.contentView addSubview:boardView];
        boardView.backgroundColor = [UIColor clearColor];
        boardView.layer.borderColor = kUIColorWithRGB(120, 138, 151).CGColor;
        boardView.layer.cornerRadius = kScaleX(6);
        boardView.layer.borderWidth = kScaleX(1);
        [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(30));
            make.right.equalTo(self.contentView).offset(kScaleX(-30));
            make.top.equalTo(self.contentView).offset(kScaleX(20));
            make.bottom.equalTo(self.contentView);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        [self.contentView addSubview:label1];
        label1.textColor = kFontBlackColor;
        label1.font = kUIFontWithMediumSize(kScaleX(14));
        label1.text = NSLocalizedString(@"角色", nil);
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(46));
            make.top.equalTo(self.contentView).offset(kScaleX(30));
        }];
        
        _roleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_roleLabel];
        _roleLabel.textColor = kFontBlackColor;
        _roleLabel.font = kUIFontWithMediumSize(kScaleX(14));
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label1);
            make.left.equalTo(self.contentView).offset(kScaleX(94));
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        [self.contentView addSubview:label2];
        label2.textColor = kFontBlackColor;
        label2.font = kUIFontWithMediumSize(kScaleX(14));
        label2.text = NSLocalizedString(@"公钥", nil);
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(46));
            make.top.equalTo(label1.mas_bottom).offset(kScaleX(20));
        }];
        
        _ppublicLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_ppublicLabel];
        _ppublicLabel.textColor = kFontBlackColor;
        _ppublicLabel.font = kUIFontWithMediumSize(kScaleX(14));
        _ppublicLabel.numberOfLines = 0;
        [_ppublicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(kScaleX(20));
            make.left.equalTo(self.contentView).offset(kScaleX(94));
            make.right.equalTo(self.contentView).offset(kScaleX(-55));
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        [self.contentView addSubview:label3];
        label3.textColor = kFontBlackColor;
        label3.font = kUIFontWithMediumSize(kScaleX(14));
        label3.text = NSLocalizedString(@"私钥", nil);
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(46));
            make.top.equalTo(self.ppublicLabel.mas_bottom).offset(kScaleX(20));
        }];
        
        _pprivateLabel = [[YYLabel alloc]init];
        [self.contentView addSubview:_pprivateLabel];
        _pprivateLabel.textColor = kFontBlackColor;
        _pprivateLabel.userInteractionEnabled = YES;
        //_pprivateLabel.editable = NO;
        _pprivateLabel.font = kUIFontWithMediumSize(kScaleX(14));
        _pprivateLabel.preferredMaxLayoutWidth = kScaleX(226);
        _pprivateLabel.numberOfLines = 0;
        [_pprivateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3);
            make.left.equalTo(self.contentView).offset(kScaleX(94));
            make.right.equalTo(self.contentView).offset(kScaleX(-55));
            make.bottom.equalTo(self.contentView).offset(kScaleX(-10));
        }];

#warning debug by zcw
        
        //[self.contentView bringSubviewToFront:_pprivateLabel];
    }
    return self;
}


- (void)setInfoModel:(ExportPrivateKeyModel *)infoModel{
    if (infoModel) {
        _roleLabel.text = infoModel.perm_name;
        _ppublicLabel.text = infoModel.account_public_key;
        //_pprivateLabel.text = @"asjfkalsjdfkajoiuoiqjoppoksdf;lakfpoqiweopqkladopipoqwelk";
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        NSString *string = infoModel.account_private_key;
        [text appendAttributedString:[[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:kUIFontWithMediumSize(kScaleX(14)),NSForegroundColorAttributeName:kFontBlackColor}]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScaleX(16), kScaleX(13))];
        imageView.image = [UIImage imageNamed:@"btn_cell_copy"];
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(kScaleX(36), kScaleX(33)) alignToFont: kUIFontWithMediumSize(kScaleX(14)) alignment:YYTextVerticalAlignmentCenter];
        
        [attachText yy_setTextHighlightRange:NSMakeRange(0, attachText.length) color:[UIColor whiteColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"-----");
        }];
        
        [text appendAttributedString:attachText];
        _pprivateLabel.attributedText = text;
    }
}
@end
