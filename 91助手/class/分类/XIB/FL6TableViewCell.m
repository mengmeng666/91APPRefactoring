//
//  FL6TableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/13.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL6TableViewCell.h"

@implementation FL6TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(FL3Model *)model{
    _model = model;
    self.xiazai.text = [NSString stringWithFormat:@"下 载:%@",model.downTimes];
    self.xiazai.font = [UIFont systemFontOfSize:14];
    self.fenlei.text = [NSString stringWithFormat:@"分 类:%@",model.cateName];
    self.fenlei.font = [UIFont systemFontOfSize:14];
    self.shijian.text = [NSString stringWithFormat:@"时 间:%@",model.updateTime];
    self.shijian.font = [UIFont systemFontOfSize:14];
    self.yuyan.text = [NSString stringWithFormat:@"语 言:%@",model.lan];
    self.yuyan.font = [UIFont systemFontOfSize:14];
    self.zuozhe.text = [NSString stringWithFormat:@"作 者:%@",model.author];
    self.zuozhe.font = [UIFont systemFontOfSize:14];
    self.jianrongxing.text = [NSString stringWithFormat:@"兼容性:%@",model.requirement];
    self.jianrongxing.font = [UIFont systemFontOfSize:14];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
