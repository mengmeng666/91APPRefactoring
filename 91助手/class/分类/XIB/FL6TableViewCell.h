//
//  FL6TableViewCell.h
//  91助手
//
//  Created by 董晓萌 on 17/1/13.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL3Model.h"
@interface FL6TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *xiazai;
@property (weak, nonatomic) IBOutlet UILabel *fenlei;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *yuyan;
@property (weak, nonatomic) IBOutlet UILabel *zuozhe;
@property (weak, nonatomic) IBOutlet UILabel *jianrongxing;
@property (nonatomic,strong)FL3Model * model;
@end
