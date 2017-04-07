//
//  FLTableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FLTableViewCell.h"
@implementation FLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(FLModel *)model{

    _model = model;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 13.0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.icon]];

    self.BTLabel.text = model.name;
    self.BTLabel.font = [UIFont systemFontOfSize:13];

    self.SLLabel.text = model.summary;
    self.SLLabel.font = [UIFont systemFontOfSize:13];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
