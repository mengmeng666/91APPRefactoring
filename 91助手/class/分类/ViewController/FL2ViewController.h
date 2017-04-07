//
//  FL2ViewController.h
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FL2Model.h"
#import "LBT2Model.h"
@interface FL2ViewController : UIViewController

@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)FL2Model * fl2model;
@property (nonatomic,strong)LBT2Model * lbt2model;

- (InvitationType)type;
@end
