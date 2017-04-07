//
//  FLModel.h
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLModel : NSObject
//主页Cell标题
@property (nonatomic,strong)NSString * name;

//主页Cell图片
@property (nonatomic,strong)NSString * icon;

//主页Cell简介
@property (nonatomic,strong)NSString * summary;

//主页数组
@property (nonatomic,strong)NSArray * listTags;
@end
