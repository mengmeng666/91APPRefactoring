//
//  LBViewController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "LBViewController.h"
#import "LBTableViewCell.h"
#import "LBModel.h"
#import "LB2ViewController.h"

@interface LBViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,strong)NSMutableArray * array;
@end
static NSString * table = @"cell";
@implementation LBViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"聊吧";
    _array = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49)style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 79;
    [self requestData];
    [_tableView registerNib:[UINib nibWithNibName:@"LBTableViewCell" bundle:nil] forCellReuseIdentifier:table];
    [self.view addSubview:_tableView];

    WeakSelf;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{

        [weakSelf requestData];
    }];
    [self.tableView.mj_header beginRefreshing];

    // Do any additional setup after loading the view.
}
- (void)requestData{
    WeakSelf;
    [_array removeAllObjects];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    [self.manager GET:@"http://applebbx.sj.91.com/api/?act=702&cuid=c0b61e0665fecc566f773be70751bdfbbcdab926&spid=2&imei=1DB79479-028B-4538-A915-9BA4B2ADD673&osv=10.1.1&dm=iPhone8,4&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray * array1 = responseObject[@"Result"];
        for (NSDictionary * dic in array1) {
            LBModel * mode = [[LBModel alloc]init];
            [mode setValuesForKeysWithDictionary:dic];
            [_array addObject:mode];
        }
        [weakSelf.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:table forIndexPath:indexPath];
    cell.model = _array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LB2ViewController * lb2 = [[LB2ViewController alloc]init];
    LBModel * model = [[LBModel alloc]init];
    model = _array[indexPath.row];
    lb2.url = model.act;
    lb2.name = model.name;
    [self.navigationController pushViewController:lb2 animated:YES];
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
