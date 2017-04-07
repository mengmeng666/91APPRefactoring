//
//  FL3TableViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL3Model.h"
@interface FL3TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TextTabel;
@property (nonatomic,strong)FL3Model * model;
@property (weak, nonatomic) IBOutlet UIButton *ZKButton;
@end
