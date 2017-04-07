//
//  YYCollectionViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "YYCollectionViewCell.h"

@implementation YYCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 13.0;
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
   // NSLog(@">>>>>>>>>>>>%@",imageUrl);
}
@end
