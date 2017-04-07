//
//  FLViewController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "FLViewController.h"
#import "FLTableViewCell.h"
#import "FLModel.h"
#import "FLCellDJViewController.h"
@interface FLViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UISegmentedControl * segment;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UITableView * YYTableView;
@property (nonatomic,strong)UITableView * YXTableView;
@property (nonatomic,strong)NSMutableArray * YYArray;
@property (nonatomic,strong)NSMutableArray * YXArray;


@end
static NSString * YYTable = @"YYCell";
static NSString * YXTable = @"YXCell";

@implementation FLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _YYArray = [NSMutableArray array];
    _YXArray = [NSMutableArray array];


    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSArray * array = [[NSArray alloc]initWithObjects:@"应用",@"游戏", nil];
    _segment = [[UISegmentedControl alloc]initWithItems:array];
    _segment.frame = CGRectMake(0, 0, 200, 30);
    _segment.selectedSegmentIndex = 0;
    _segment.backgroundColor = [UIColor blackColor];
    _segment.tintColor = [UIColor whiteColor];
    [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_segment];
    self.navigationItem.titleView = view;

    self.automaticallyAdjustsScrollViewInsets = NO;

 
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0,ScreenWidth, ScreenHeight - 64 - 49);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64-49);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [self requestData];

    [self setTableView];
    WeakSelf;
    _YYTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [_YYTableView.mj_header beginRefreshing];

    _YXTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [_YXTableView.mj_header beginRefreshing];

    // Do any additional setup after loading the view.
}
- (void)setTableView{

    //应用界面
    _YYTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _YYTableView.dataSource = self;
    _YYTableView.delegate = self;
    _YYTableView.rowHeight = 85;
    [_YYTableView registerNib:[UINib nibWithNibName:@"FLTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_scrollView addSubview:_YYTableView];

    //游戏界面
    _YXTableView = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0,ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _YXTableView.dataSource = self;
    _YXTableView.delegate = self;
    _YXTableView.rowHeight = 85;
    [_YXTableView registerNib:[UINib nibWithNibName:@"FLTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_scrollView addSubview:_YXTableView];
    
}

- (void)requestData{

    NSString * YYStr = @"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&pi=1&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2";
    NSString * YXStr = @"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=218&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&pi=1&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2";
    WeakSelf;
    [_YYArray removeAllObjects];
    [_YXArray removeAllObjects];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager * manager1 = [AFHTTPSessionManager manager];

    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager GET:YYStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = responseObject[@"Result"];
        for (NSDictionary * dic in array) {
            FLModel * model = [[FLModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_YYArray addObject:model];
        }
        [weakSelf.YYTableView reloadData];
        [weakSelf.YYTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"saasdasdas%@",error);
    }];

    [manager1.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager1 GET:YXStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = responseObject[@"Result"];
        for (NSDictionary * dic in array) {
            FLModel * model = [[FLModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_YXArray addObject:model];
        }
        [weakSelf.YXTableView reloadData];
        [weakSelf.YXTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"saasdasdasss%@",error);
    }];
}
- (void)segmentAction:(UISegmentedControl *)Seg{
    if (Seg.selectedSegmentIndex == 0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }else{
        _scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        if (scrollView.contentOffset.x / ScreenWidth == 1) {
            _segment.selectedSegmentIndex = 1;
        }else if(scrollView.contentOffset.x / ScreenWidth == 0){
            _segment.selectedSegmentIndex = 0;
        }
    }else{

    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        if (scrollView.contentOffset.x / ScreenWidth == 1) {
            _segment.selectedSegmentIndex = 1;
        }else if(scrollView.contentOffset.x / ScreenWidth == 0){
            _segment.selectedSegmentIndex = 0;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _YYTableView) {

        return self.YYArray.count;
    }else{
        return self.YXArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _YYTableView) {

        FLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        FLModel * model = [[FLModel alloc]init];
        model = _YYArray[indexPath.row];
        cell.model = model;
        return cell;
    }else{
        FLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        FLModel * model = [[FLModel alloc]init];
        model = _YXArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FLCellDJViewController * fl = [[FLCellDJViewController alloc]init];
    fl.fl2model = [[FL2Model alloc]init];
    FLModel * model = [[FLModel alloc]init];
    if (tableView == _YYTableView) {
        model = _YYArray[indexPath.row];
    }else{
        model = _YXArray[indexPath.row];
    }
    fl.name = model.name;
    NSDictionary * dic = model.listTags[0];
    [fl.fl2model setValuesForKeysWithDictionary:dic];
    [self.navigationController pushViewController:fl animated:YES];
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
