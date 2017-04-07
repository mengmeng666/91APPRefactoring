//
//  FL6ViewController.h
//  91助手
//
//  Created by 董晓萌 on 17/1/13.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBT2Model.h"
#import "FL3Model.h"
#import "FL4Model.h"
@interface FL6ViewController : UIViewController

@property (nonatomic,strong)LBT2Model * model;
@property (nonatomic,strong)NSString * url;

@property (nonatomic,strong)FL3Model * fl3Mod;
@property (nonatomic,strong)FL4Model * fl4Mod;

@end
