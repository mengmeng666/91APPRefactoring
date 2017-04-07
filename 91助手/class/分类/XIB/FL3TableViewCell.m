//
//  FL3TableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL3TableViewCell.h"

@implementation FL3TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(FL3Model *)model{

    _model = model;
    self.TextTabel.text = model.desc;
    //self.TextTabel.font = [UIFont systemFontOfSize:13];
    self.TextTabel.textColor = [UIColor grayColor];
}
- (IBAction)ZKButton:(id)sender {

    [[NSNotificationCenter defaultCenter]postNotificationName:@"zhankai" object:@""];
    if (self.model.height == 120) {
        [self.ZKButton setTitle:@"收缩" forState:0];
        //MAXFLOAT最大值
        CGFloat width = ScreenWidth - 2 * 8;
        CGFloat height = [self.model.desc boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        self.model.height = height + 80;
        //NSLog(@"ppppppppppp%f",self.model.height);
    }else{
        [self.ZKButton setTitle:@"展开" forState:UIControlStateNormal];
        self.model.height = 120;
         //NSLog(@"pppppppppppssssss%f",self.model.height);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
