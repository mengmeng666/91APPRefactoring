//
//  LB3ViewController.m
//  91助手
//
//  Created by 董晓萌 on 17/1/3.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "LB3ViewController.h"

@interface LB3ViewController ()

@end

@implementation LB3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"百度贴吧";

    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];

    //把中文转换成UTF-8
    NSString * str = [_name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];

    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tieba.baidu.com/f?kw=%@&fr=ala0&tpl=5",str]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    [webView loadRequest:request];
    [self.view addSubview:webView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
