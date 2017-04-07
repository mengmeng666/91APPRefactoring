//
//  FL2ViewController.m
//  91助手
//
//  Created by 董晓萌 on 17/1/11.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL2ViewController.h"
#import "SYTableViewCell.h"
//#import "FL6TableViewController.h"
#import "FL6ViewController.h"
@interface FL2ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)NSString * url;
@property (nonatomic,strong)NSMutableArray * array;
@property (nonatomic,assign)int  pi;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@end

@implementation FL2ViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (InvitationType)type
{
    return InvitationTypeMianFei;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.name;
    _array = [NSMutableArray array];

    _url = @"";
    _url = [self.fl2model.url stringByReplacingOccurrencesOfString:@"pt=1" withString:[NSString stringWithFormat:@"pt=%d",self.type]];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,30, ScreenWidth, ScreenHeight - 64 - 49 -30) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor= [UIColor whiteColor];
    tableView.rowHeight = 90;
    //[tableView registerNib:[UINib nibWithNibName:@"SYTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView = tableView;
    [self.view addSubview:tableView];

    [self setupRefresh];

    // Do any additional setup after loading the view.
}

- (void)setupRefresh
{
    [self requsetData];

    WeakSelf;
    //下拉
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf requsetData];
    }];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    //上拉
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)requsetData{
    WeakSelf;
    _pi = 1;
    [_array removeAllObjects];
    // 请求参数
    NSMutableDictionary * mutable = [NSMutableDictionary dictionary];
    mutable[@"pi"] = @(self.pi);
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:_url parameters:mutable progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * arrya = dic[@"items"];
        for (NSDictionary * dic1 in arrya) {

            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [_array addObject:model];
        }
        //NSLog(@"---------------%@",self.array);

        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"sdasdasdsd%@",error);
    }];
}
- (void)loadMoreData{
    WeakSelf;
    _pi ++;

    NSMutableDictionary * mutable = [NSMutableDictionary dictionary];
    mutable[@"pi"] = [NSString stringWithFormat:@"%d",self.pi];

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:_url parameters:mutable progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * arrya = dic[@"items"];
        for (NSDictionary * dic1 in arrya) {

            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [_array addObject:model];
        }

        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//- (void)didSelectedTheButtonNumberIs:(int)number;{
//
//    _scrollView.contentOffset = CGPointMake(ScreenWidth * number, 0);
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SYTableViewCell class]) owner:self options:nil] firstObject];
    }else{
        while ([cell.contentView.subviews lastObject]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

 }
    cell.model = _array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
    self.lbt2model = _array[indexPath.row];
    fl6.url = self.lbt2model.detailUrl;
    fl6.hidesBottomBarWhenPushed = YES;

    [self presentViewController:fl6 animated:YES completion:nil];;
    
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
