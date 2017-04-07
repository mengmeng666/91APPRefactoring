//
//  FL2TableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL2TableViewCell.h"

@implementation FL2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    // Initialization code
}
- (void)setModel:(FL3Model *)model{

    _model = model;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 13.0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.DXLabel.text = [NSString stringWithFormat:@"大小:%0.2fMB",model.size/1024/1024.0];
    self.DXLabel.font = [UIFont systemFontOfSize:12];
    self.BBLabel.text = [NSString stringWithFormat:@"版本:%@",model.versionCode];
    self.BBLabel.font = [UIFont systemFontOfSize:12];

    self.Label.text = model.name;
    self.Label.textColor = [UIColor whiteColor];
    [self.DKButton setTitle:[NSString stringWithFormat:@"打开%@吧",model.name] forState:UIControlStateNormal];
    self.DKButton.layer.cornerRadius = 5;
    self.DKButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.DKButton setTintColor:[UIColor whiteColor]];
    if ([model.price isEqualToString:@"0.00"]) {
        [self.MFButton setTitle:@"免费" forState:UIControlStateNormal];
    }else{
        [self.MFButton setTitle:model.price forState:UIControlStateNormal];
    }
    if (model.star == 1) {

       // NSLog( @"sadasdasdada%ld",(long)_model.star);
        self.star1.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star2.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star3.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star4.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star5.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];

    }else if (model.star == 2){

        self.star1.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star2.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star3.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star4.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star5.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];

    }else if (model.star == 3){

        self.star1.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star2.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star3.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star4.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];
        self.star5.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];;

    }else if (model.star == 4){

        self.star1.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star2.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star3.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star4.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star5.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_n"];

    }else if (model.star == 5){
        self.star1.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star2.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star3.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star4.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
        self.star5.image = [UIImage imageNamed:@"btn_star_collect_pb_floor_s"];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
