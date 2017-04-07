//
//  FLTableViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLModel.h"
@interface FLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *BTLabel;
@property (weak, nonatomic) IBOutlet UILabel *SLLabel;
@property (nonatomic,strong) FLModel * model;
@end
