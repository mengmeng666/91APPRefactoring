//
//  TabBarController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "TabBarController.h"
#import "FLViewController.h"
#import "SSViewController.h"
#import "LBViewController.h"
#import "SYViewController.h"
#import "NavigationController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setZiDingYi];

    [self setTabbarController:[[SYViewController alloc]init] Title:@"首页" image:@"homepage_home" seleImage:@"homepage_home_sel"];
    [self setTabbarController:[[LBViewController alloc]init] Title:@"聊吧" image:@"homepage_talk" seleImage:@"homepage_talk_sel"];
    [self setTabbarController:[[FLViewController alloc]init] Title:@"分类" image:@"homepage_cate" seleImage:@"homepage_cate_sel"];
    [self setTabbarController:[[SSViewController alloc]init] Title:@"搜索" image:@"homepage_seach" seleImage:@"homepage_seach_sel"];


    // Do any additional setup after loading the view.
}

- (void)setZiDingYi{

    UITabBar * bar = [UITabBar appearance];

    [bar setBackgroundImage:[UIImage imageNamed:@"tabBar.png"]];

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];

    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14];

    NSMutableDictionary * seleDict = [NSMutableDictionary dictionary];

    seleDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:255 / 256.0 green:193 / 256.0 blue:77 / 256.0 alpha:1];

    UITabBarItem * itme = [UITabBarItem appearance];

    [itme setTitleTextAttributes:dic forState:UIControlStateNormal];
    [itme setTitleTextAttributes:seleDict forState:UIControlStateSelected];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabbarController:(UIViewController *)viewController Title:(NSString *)title image:(NSString *)image seleImage:(NSString *)seleImage{

    NavigationController * nav = [[NavigationController alloc]initWithRootViewController:viewController];

    [self addChildViewController:nav];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:seleImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
