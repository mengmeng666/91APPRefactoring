//
//  FL6ViewController.m
//  91助手
//
//  Created by 董晓萌 on 17/1/13.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL6ViewController.h"
#import "FL2TableViewCell.h"
#import "FL3TableViewCell.h"
#import "FL4TableViewCell.h"
#import "FL6TableViewCell.h"
@interface FL6ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * TPArray;
@property (nonatomic,strong)NSMutableArray * arrayUrl;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation FL6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fl3Mod = [[FL3Model alloc]init];

    _TPArray = [NSMutableArray array];
    _arrayUrl = [NSMutableArray array];
    _fl3Mod.height = 120;

    

    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    [_tableView registerNib:[UINib nibWithNibName:@"FL2TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [_tableView registerNib:[UINib nibWithNibName:@"FL3TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];

    //[self.tableView registerNib:[UINib nibWithNibName:@"FL4TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [_tableView registerClass:[FL4TableViewCell class] forCellReuseIdentifier:@"cell2"];

    [_tableView registerNib:[UINib nibWithNibName:@"FL6TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.view insertSubview:_tableView atIndex:0];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bian) name:@"zhankai" object:@""];
    //[self.tableView reloadData];

    [self requsetData];
    // Do any additional setup after loading the view from its nib.
}
- (void)bian{
    [self.tableView reloadData];
}

- (IBAction)fanhui:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)fenxiang:(id)sender {
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //self.navigationController.navigationBar.hidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaozhaun:) name:TONGZHI object:nil];
}
- (void)tiaozhaun:(NSNotification *)index{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:TONGZHI object:nil];
    NSString * url = index.userInfo[@"url"];

    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
    fl6.url = url;
   // NSLog(@"sdasdasdasd%@",url);
    //[self.view.window.rootViewController presentViewController:fl6 animated:YES completion:nil];
    [self presentViewController:fl6 animated:YES completion:nil];
}
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"zhankai" object:nil];

}
- (void)requsetData{
    WeakSelf;
    [_TPArray removeAllObjects];
    [_arrayUrl removeAllObjects];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager GET:self.url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        [self.fl3Mod setValuesForKeysWithDictionary:dic];
        //NSLog(@"sadsdasdasd%@",responseObject[@"Result"]);
        //NSLog(@"sadsda-------sdasd%@",self.fl3Mod);

        NSArray * array = dic[@"snapshots"];
        NSArray * array1 = dic[@"recommendSofts"];
        for (NSDictionary * dic1 in array1) {
            FL4Model * model = [[FL4Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [_TPArray addObject:model.icon];
            [_arrayUrl addObject:model.detailUrl];
        }
       // NSLog(@"---------------%@",self.TPArray);

        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 300) imageURLStringsGroup:array];
        //scrollView.delegate = self;
        weakSelf.tableView.tableHeaderView = scrollView;
        [weakSelf.tableView insertSubview:scrollView atIndex:0];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"sdasdasdsd%@",error);
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 96;
    }else if (indexPath.row == 1){
        //NSLog(@"sssssssssssssssssssssssss%f",_fl3Mod.height);
        return self.fl3Mod.height;
        //return 120;
    }else if (indexPath.row == 2){
        return 120;
    }else if (indexPath.row == 3){
        return 210;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {

        FL2TableViewCell * fl2 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        fl2.model = self.fl3Mod;
        return fl2;
    }else if (indexPath.row == 1){

        FL3TableViewCell * fl3 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        fl3.model = self.fl3Mod;
        return fl3;
    }else if (indexPath.row == 2){

        FL4TableViewCell * fl4 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        fl4.TPArray = _TPArray;
        fl4.arryaUrl = _arrayUrl;
        return fl4;
    }else if (indexPath.row == 3){

        FL6TableViewCell * fl6 = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];

        fl6.model = self.fl3Mod;
        return fl6;
    }
    return 0;
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
