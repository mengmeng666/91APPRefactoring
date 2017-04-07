//
//  FL3Model.h
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FL3Model : NSObject

//标题
@property (nonatomic,copy)NSString * name;
//图片
@property (nonatomic,copy)NSString * icon;
//版本号
@property (nonatomic,copy)NSString * versionCode;
//价格
@property (nonatomic,copy)NSString * price;
//兼容性
@property (nonatomic,copy)NSString * requirement;
//语言
@property (nonatomic,copy)NSString * lan;
//应用简介
@property (nonatomic,copy)NSString * desc;
//下载网址
@property (nonatomic,copy)NSString * downAct;
//下载次数
@property (nonatomic,copy)NSString * downTimes;
//时间
@property (nonatomic,copy)NSString * updateTime;
//分类
@property (nonatomic,copy)NSString * cateName;
//作者
@property (nonatomic,copy)NSString * author;
//星星
@property (nonatomic,assign)NSInteger star;
//大小
@property (nonatomic,assign)NSInteger size;

@property (nonatomic,assign)CGFloat height;
@end
