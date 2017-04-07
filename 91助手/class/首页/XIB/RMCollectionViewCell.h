//
//  RMCollectionViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL3Model.h"

@interface RMCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic,strong)NSString * label;
@property (nonatomic,strong)NSString * imageUrl;


@end
