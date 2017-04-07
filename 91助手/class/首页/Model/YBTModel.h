//
//  YBTModel.h
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBTModel : NSObject

//标题
@property (nonatomic,strong)NSString * Desc;
//图片点击网址
@property (nonatomic,strong)NSString * TargetUrl;
//图片网址
@property(nonatomic,copy)NSString * LogoUrl;

@end
