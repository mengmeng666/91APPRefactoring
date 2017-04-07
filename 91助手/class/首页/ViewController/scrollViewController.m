//
//  scrollViewController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "scrollViewController.h"
#import "LBT2Model.h"
#import "SYTableViewCell.h"
#import "FL6ViewController.h"
@interface scrollViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,strong)NSMutableArray * DJLBArray;
@end
static NSString * table = @"cell1";
@implementation scrollViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _DJLBArray = [NSMutableArray array];

    self.navigationItem.title = self.desc;

    //'NSLog(@"SDASDSAS%@",self.desc);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 90;
    //[_tableView registerNib:[UINib nibWithNibName:@"SYTableViewCell" bundle:nil] forCellReuseIdentifier:table];
    [self.view addSubview:self.tableView];
    [self requestData];
    WeakSelf;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestData{
    WeakSelf;
    [_DJLBArray removeAllObjects];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:self.targetUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {

            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [_DJLBArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DJLBArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:table];

    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SYTableViewCell class]) owner:self options:nil] firstObject];
    }else{
        while ([cell.contentView.subviews lastObject]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }

    cell.model = self.DJLBArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
    LBT2Model * model = [[LBT2Model alloc]init];
    model = _DJLBArray[indexPath.row];
    fl6.url = model.detailUrl;
    fl6.hidesBottomBarWhenPushed = YES;

    [self presentViewController:fl6 animated:YES completion:nil];;
    
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
