//
//  YY2TableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/17.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "YY2TableViewCell.h"

@implementation YY2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SYModel *)model{
    _model = model;
    self.biaoti.text = model.name;
    self.jianjie.text = model.summary;

    [self.image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
