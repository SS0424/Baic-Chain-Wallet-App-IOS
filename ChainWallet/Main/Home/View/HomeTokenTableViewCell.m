//
//  HomeTokenTableViewCell.m
//  ChainWallet
//
//  Created by apple on 2018/11/3.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "HomeTokenTableViewCell.h"

@implementation HomeTokenTableViewCell

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
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.tokenImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.tokenImgView];
        [_tokenImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kScaleX(30), kScaleX(30)));
            make.left.equalTo(self.contentView).offset(kScaleX(30));
        }];
        
        self.tokenNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.tokenNameLabel];
        _tokenNameLabel.textColor = kFontBlackColor;
        _tokenNameLabel.font = kUIFontWithMediumSize(kScaleX(19));
        [_tokenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.tokenImgView.mas_right).offset(kScaleX(10));
        }];
        
        self.tokenCountLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.tokenCountLabel];
        _tokenCountLabel.textColor = kFontBlackColor;
        _tokenCountLabel.textAlignment = NSTextAlignmentRight;
        _tokenCountLabel.font = kUIFontWithMediumSize(kScaleX(19));
        [_tokenCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kScaleX(11));
            make.right.equalTo(self.contentView).offset(-kScaleX(30));
        }];
        
        self.tokenValueLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.tokenValueLabel];
        _tokenValueLabel.textColor = kUIColorWithRGB(149, 168, 182);
        _tokenValueLabel.textAlignment = NSTextAlignmentRight;
        _tokenValueLabel.font = kUIFontWithMediumSize(kScaleX(11));
        [_tokenValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tokenCountLabel.mas_bottom);
            make.right.equalTo(self.contentView).offset(-kScaleX(30));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = kUIColorWithRGB(240, 243, 244);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(30));
            make.right.equalTo(self.contentView).offset(-kScaleX(30));
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(kScaleX(1)));
        }];
        

    }
    return self;
}

- (void)setModel:(TokenModel *)model{
    if (model) {
#warning debug by zcw
        _tokenImgView.image = kUIImageNamed(@"test_icon_token");
        _tokenNameLabel.text = model.token;
        _tokenCountLabel.text = model.count;
        _tokenValueLabel.text = @"￥10.00";
    }
}
@end
