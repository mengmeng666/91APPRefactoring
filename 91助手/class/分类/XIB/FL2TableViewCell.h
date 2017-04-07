//
//  FL2TableViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL3Model.h"
@interface FL2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *DXLabel;
@property (weak, nonatomic) IBOutlet UILabel *BBLabel;
@property (weak, nonatomic) IBOutlet UIButton *MFButton;
@property (weak, nonatomic) IBOutlet UIButton *DKButton;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (nonatomic,strong)FL3Model * model;
@end
