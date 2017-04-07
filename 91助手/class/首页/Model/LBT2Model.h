//
//  LBT2Model.h
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBT2Model : NSObject

//图标图片
@property (nonatomic,strong)NSString * icon;
//名字
@property (nonatomic,strong)NSString * name;
//星星
@property (nonatomic,assign)NSInteger star;
//几次下载
@property (nonatomic,strong)NSString * downTimes;
//大小
@property (nonatomic,assign )NSInteger size;
//点击网址
@property (nonatomic,strong)NSString * detailUrl;
//原价格
@property(nonatomic,copy)NSString * originalPrice;
//现价格
@property(nonatomic,copy)NSString * price;
//下载请求网址
@property(nonatomic,copy)NSString * downAct;
@end
