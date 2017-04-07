//
//  YYCollectionViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic,strong)NSString * imageUrl;
@end
