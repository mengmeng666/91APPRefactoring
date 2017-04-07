//
//  LBTableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 16/12/30.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "LBTableViewCell.h"
#import "LBViewController.h"
#import "LB2ViewController.h"
@interface LBTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *biaoti;

@property (nonatomic,strong) LBViewController * lbView;
@property (nonatomic,strong) LB2ViewController * lb2View;
@end
@implementation LBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(LBModel *)model{
    _model = model;
    _image.layer.masksToBounds = YES;
    _image.layer.cornerRadius = 13.0;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.icon]];

    if (!model.act) {

        _biaoti.text =[NSString stringWithFormat:@"%@吧",model.name];
    }else{
    _biaoti.text = model.name;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
