//
//  SYTableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "SYTableViewCell.h"

@interface SYTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

@property (weak, nonatomic) IBOutlet UILabel *yuanjia;
@property (weak, nonatomic) IBOutlet UILabel *xianjia;
@property (weak, nonatomic) IBOutlet UILabel *xiazailiang;
@property (weak, nonatomic) IBOutlet UILabel *daxiao;
@property (weak, nonatomic) IBOutlet UIView *xian;

@property (weak, nonatomic) IBOutlet UIButton *button;

@end
@implementation SYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}
- (void)setModel:(LBT2Model *)model{

    _model = model;
    //图标
    _image.layer.masksToBounds = YES;
    _image.layer.cornerRadius = 13.0;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    //名字
    _nameLabel.text = model.name;
    _nameLabel.font = [UIFont systemFontOfSize:16];

    //下载量
    _xiazailiang.text = [NSString stringWithFormat:@"%@次下载",model.downTimes];
    _xiazailiang.font = [UIFont systemFontOfSize:13];
    //大小
    _daxiao.text = [NSString stringWithFormat:@"%0.2fMB",model.size/1024/1024.0];
    _daxiao.font = [UIFont systemFontOfSize:13];

    if (model.star == 1) {

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

    self.yuanjia.font = [UIFont systemFontOfSize:11];
    self.button.layer.cornerRadius = 5.0;

    if ([model.price isEqualToString:@"0.00"]) {
        _xianjia.hidden = YES;
        if ([model.originalPrice isEqualToString:@"0.00"]) {
            _yuanjia.hidden = YES;
            _xian.hidden = YES;
        }else{
            _yuanjia.text = model.originalPrice;
        }
    }else{
        
        _button.hidden = YES;
        if ([model.originalPrice isEqualToString:@"0.00"]) {
            _yuanjia.hidden = YES;
            _xian.hidden = YES;
            _xianjia.text = model.price;
        }else{

            _xianjia.text = model.price;
            _yuanjia.text = model.originalPrice;
        }
    }


}
- (IBAction)mianfei:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
