//

//
//  Created by 董晓萌 on 16/12/5.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "UIBarButtonItem+Category.h"

@implementation UIBarButtonItem (Category)


+ (instancetype)setTitle:(NSString *)title TitleColor:(UIColor *)titleColor seleTitleColor:(UIColor *)seleTitleColor image:(NSString *)image highImage:(NSString *)highimage target:(id)target action:(SEL)action{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return [[self alloc]initWithCustomView:button];
}




@end
