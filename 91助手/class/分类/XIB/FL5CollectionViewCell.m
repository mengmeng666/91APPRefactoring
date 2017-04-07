//
//  FL5CollectionViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL5CollectionViewCell.h"

@implementation FL5CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setArrayUrl:(NSString *)arrayUrl{
    
    _arrayUrl = arrayUrl;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 13.0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:arrayUrl]];
   // NSLog(@"=================%@",arrayUrl);
}
@end
