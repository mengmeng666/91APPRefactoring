//
//  SS2ViewController.m
//  91助手
//
//  Created by 董晓萌 on 17/1/17.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "SS2ViewController.h"
#import "LBTableViewCell.h"
#import "LB3ViewController.h"
@interface SS2ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,strong)NSMutableArray * array;
@end

@implementation SS2ViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _array = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49)style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 79;
    [_tableView registerNib:[UINib nibWithNibName:@"LBTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self requestData];

    // Do any additional setup after loading the view.
}
- (void)requestData{
    WeakSelf;
    [_array removeAllObjects];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    [self.manager GET:self.url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic in array) {
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

    LBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LB3ViewController * lb3 = [[LB3ViewController alloc]init];
    LBModel * model = [[LBModel alloc]init];
    lb3.name = model.name;

    [self.navigationController pushViewController:lb3 animated:YES];


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
