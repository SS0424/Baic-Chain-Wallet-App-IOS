//
//  TokenTradeTableViewCell.m
//  ChainWallet
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zcw. All rights reserved.
//

#import "TokenTradeTableViewCell.h"

@implementation TokenTradeTableViewCell

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
        
        _stateImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_stateImgView];
        [_stateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kScaleX(30));
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kScaleX(30), kScaleX(30)));
        }];
        
        self.tokenNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.tokenNameLabel];
        _tokenNameLabel.textColor = kFontBlackColor;
        _tokenNameLabel.font = kUIFontWithMediumSize(kScaleX(16));
        [_tokenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.stateImgView.mas_right).offset(kScaleX(10));
            make.top.equalTo(self.contentView).offset(kScaleX(19));
        }];
        
        self.timelabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.timelabel];
        _timelabel.textColor = kUIColorWithRGB(149, 168, 182);
        _timelabel.font = kUIFontWithMediumSize(kScaleX(14));
        [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.stateImgView.mas_right).offset(kScaleX(10));
            make.top.equalTo(self.tokenNameLabel.mas_bottom).offset(kScaleX(2));
        }];

        self.countLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.countLabel];
        _countLabel.textColor = kFontBlackColor;
        _countLabel.font = kUIFontWithMediumSize(kScaleX(19));
        _countLabel.textAlignment = NSTextAlignmentRight;
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-kScaleX(30));
            make.centerY.equalTo(self.contentView);
        }];

    }
    return self;
}
@end
