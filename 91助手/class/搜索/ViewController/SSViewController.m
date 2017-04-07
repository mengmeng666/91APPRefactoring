//
//  SSViewController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "SSViewController.h"
#import "SS2ViewController.h"
#import "scrollViewController.h"
@interface SSViewController ()<UISearchBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UISearchBar * search;
@property (nonatomic,strong)NSMutableArray * array;
@property (nonatomic,strong)UIView * buttonView;
@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UIView  * segmentView;
@property (nonatomic,strong)UISegmentedControl * segmented;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)NSString * url;
@property (nonatomic,strong)SS2ViewController * ss;
@property (nonatomic,strong)scrollViewController * scro;
@property (nonatomic,strong)UIView * view2;
@property (nonatomic,strong)NSMutableArray * array2;
@property (nonatomic,strong)UIButton * button1;
@property (nonatomic,strong)UIButton * button2;


@end

#define GETURL @"http://applebbx.sj.91.com/softs.ashx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=104&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2"

@implementation SSViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _array = [NSMutableArray array];
    _array2 = [NSMutableArray array];

    self.view.backgroundColor = [UIColor whiteColor];
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0 , 0, 400, 50)];
    _search.placeholder = @"搜索";
    _search.delegate = self;
    self.navigationItem.titleView = self.search;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 30)];
    label.text = @"热门搜索";
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, ScreenWidth - 30, 200)];
    [self.view addSubview:_buttonView];
    self.navigationItem.titleView = self.search;
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 245, 70, 30)];
    label2.text = @"历史搜索";
    label2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label2];
    _view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 270, ScreenWidth - 30, 300)];
    //_view2.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_view2];
    [self requestData];


    // Do any additional setup after loading the view.
}

- (void)requestData{

    [_array removeAllObjects];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager GET:GETURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _array = responseObject[@"Result"];
        for (int i = 0; i < self.array.count; i++) {

            _button = [UIButton buttonWithType:UIButtonTypeCustom];
            _button.layer.cornerRadius = 9;
            _button.frame = CGRectMake((i % 4 * 90) + 20, (( i / 4) + 0.5) * 45, 80, 35);
            [_button setTitle:self.array[i] forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _button.titleLabel.font = [UIFont systemFontOfSize:14];
            _button.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0 green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1];
            [_button addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonView addSubview:_button];
        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

}
- (void)setScrollView{

    NSArray * array = [[NSArray alloc]initWithObjects:@"聊吧",@"应用", nil];
    _segmentView = [[UIView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth , ScreenHeight- 49 - 64)];
    _segmentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_segmentView];
    _segmented = [[UISegmentedControl alloc]initWithItems:array];
    _segmented.selectedSegmentIndex = 1;
    _segmented.frame = CGRectMake(0, 10, 250, 30);
    _segmented.center = CGPointMake(self.view.centerX, 20);
    [_segmented addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [_segmentView addSubview:_segmented];

    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 40,ScreenWidth, ScreenHeight - 64 - 49);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64-49);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self setzishitu];
    [_scrollView becomeFirstResponder];//成为第一响应者
    [self scrollViewDidEndScrollingAnimation:_scrollView];
    [_segmentView addSubview:_scrollView];

}

- (void)setzishitu{
    _ss = [[SS2ViewController alloc]init];
    _ss.url = self.url;
    [self addChildViewController:_ss];

    _scro = [[scrollViewController alloc]init];
    _scro.targetUrl = self.url;
    [self addChildViewController:_scro];

}
- (void)segmentAction:(UISegmentedControl *)Seg{
    if (Seg.selectedSegmentIndex == 0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }else{
        _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    int index = _scrollView.contentOffset.x / ScreenWidth;
    UIViewController *willShowChildVc = self.childViewControllers[index];

    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;

    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = _scrollView.bounds;
    [_scrollView addSubview:willShowChildVc.view];
}
- (void)dianji:(UIButton *)button{

    _button = button;
    _search.text = button.titleLabel.text;
    NSString * str = [[NSString alloc]init];
    str = [button.titleLabel.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    _url = [NSString stringWithFormat:@"http://applebbx.sj.91.com/api/?spid=2&pi=1&osv=9.3.4&keyword=%@&dm=iPhone5,4&sv=3.1.3&act=203&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1",str];
    [_array2 addObject:button.titleLabel.text];
    for (int i = 0; i < self.array2.count; i++) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.layer.cornerRadius = 9;
        _button1.frame = CGRectMake((i % 4 * 90) + 20, (( i / 4) + 0.5) * 45, 80, 35);
        [_button1 setTitle:self.array2[i] forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        _button1.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0 green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1];
        [_button1 addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:_button1];
        //NSLog(@">>>>>>>>>>>>>>>>>>>>>>>%@",self.array2);

    }
    [self setScrollView];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //_search = searchBar;
    NSString * str = [NSString string];
    str = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    _url = [NSString stringWithFormat:@"http://applebbx.sj.91.com/api/?spid=2&pi=1&osv=9.3.4&keyword=%@&dm=iPhone5,4&sv=3.1.3&act=203&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1",str];

    [self setScrollView];
    [self quxiao];
    [self.array2 addObject:searchBar.text];
    for (int i = 0; i < self.array2.count; i++) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.layer.cornerRadius = 9;
        _button1.frame = CGRectMake((i % 4 * 90) + 20, (( i / 4) + 0.5) * 45, 80, 35);
        [_button1 setTitle:self.array2[i] forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        _button1.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0 green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1];

        [_button1 addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>%@",self.array2);
        [_view2 addSubview:_button1];

    }

}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView * view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * button =(UIButton *)view;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (_search.text.length == 0) {

        [self.segmentView removeFromSuperview];
        [self.ss removeFromParentViewController];
        [self.scro removeFromParentViewController];
        [self quxiao];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_search resignFirstResponder];
    _search.showsCancelButton = NO;
}
- (void)quxiao{

    [_search resignFirstResponder];
    _search.showsCancelButton = NO;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        if (scrollView.contentOffset.x / ScreenWidth == 1) {
            _segmented.selectedSegmentIndex = 1;
        }else if(scrollView.contentOffset.x / ScreenWidth == 0){
            _segmented.selectedSegmentIndex = 0;
        }
    }else{

    }
    int index = scrollView.contentOffset.x / ScreenWidth;
    UIViewController *willShowChildVc = self.childViewControllers[index];

    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;

    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
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
