//
//  RMCollectionViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "RMCollectionViewCell.h"
@implementation RMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setImageUrl:(NSString *)imageUrl{

    _imageUrl = imageUrl;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 13.0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}
- (void)setLabel:(NSString *)label{

    _label = label;
    self.name.text = label;
//    NSLog(@"0000000000000000%@",label);
    self.name.font = [UIFont systemFontOfSize:12];

}
@end
