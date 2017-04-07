//
//  YYViewController.m
//  91助手
//
//  Created by 董晓萌 on 17/1/17.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "YYViewController.h"
#import "YY2TableViewCell.h"
#import "SYModel.h"
#import "scrollViewController.h"
@interface YYViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * SYArray;

@end

@implementation YYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.desc;
    _SYArray = [NSMutableArray array];


    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 280;
    [_tableView registerNib:[UINib nibWithNibName:@"YY2TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self requestData];

    // Do any additional setup after loading the view.
}

- (void)requestData{

    WeakSelf;
    [_SYArray removeAllObjects];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager GET:self.url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = responseObject[@"Result"];
        for (NSDictionary * dic1 in array) {

            SYModel * model = [[SYModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.SYArray addObject:model];
            //NSLog(@">>>>>>>>>>>>%@",self.SYArray);
            //[self.SYArray  addObject:model.url];
        }
        [weakSelf.tableView reloadData];
        //[weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.SYArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YY2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.model = self.SYArray[indexPath.row];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    scrollViewController * scroll = [[scrollViewController alloc]init];
    SYModel * model = [[SYModel alloc]init];
    model = self.SYArray[indexPath.row];
    scroll.desc = model.name;
    scroll.targetUrl = model.url;
    [self.navigationController pushViewController:scroll animated:YES];

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
