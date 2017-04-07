//
//  YY2TableViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/17.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYModel.h"
@interface YY2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaoti;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;

@property (nonatomic,strong)SYModel * model;
@end
