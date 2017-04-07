//
//  SYViewController.m
//  91助手
//
//  Created by 董晓萌 on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "SYViewController.h"
#import "YBTModel.h"
#import "scrollViewController.h"
#import "FL3Model.h"
#import "RMTableViewCell.h"
#import "FL6ViewController.h"
#import "SYTableViewCell.h"
#import "LBT2Model.h"
#import "YYTableViewCell.h"
#import "SYModel.h"
#import "YYViewController.h"
@interface SYViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)SDCycleScrollView * scrollView;
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@property (nonatomic,strong)NSMutableArray * LBTArray;
@property (nonatomic,strong)NSMutableArray * RMTPArray;
@property (nonatomic,strong)NSMutableArray * RMNameArray;
@property (nonatomic,strong)NSMutableArray * RMURLArray;
@property (nonatomic,strong)NSMutableArray * JPArray;
@property (nonatomic,strong)NSMutableArray * XSTPArray;
@property (nonatomic,strong)NSMutableArray * XSNameArray;
@property (nonatomic,strong)NSMutableArray * XSURLArray;
@property (nonatomic,strong)NSMutableArray * ZJTPArray;
@property (nonatomic,strong)NSMutableArray * ZJNameArray;
@property (nonatomic,strong)NSMutableArray * ZJURLArray;
@property (nonatomic,strong)NSMutableArray * YYTPArray;
@property (nonatomic,strong)NSMutableArray * YYNameArray;
@property (nonatomic,strong)NSMutableArray * YYURLArray;
@property (nonatomic,strong)NSMutableArray * HMArray;
@property (nonatomic,strong)NSMutableArray * TJArray;
@property (nonatomic,strong)NSMutableArray * SYArray;
@property (nonatomic,strong)UILabel * label;


@end
@implementation SYViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _LBTArray = [NSMutableArray array];
    _RMTPArray = [NSMutableArray array];
    _RMNameArray = [NSMutableArray array];
    _RMURLArray = [NSMutableArray array];
    _JPArray = [NSMutableArray array];
    _XSTPArray = [NSMutableArray array];
    _XSNameArray = [NSMutableArray array];
    _XSURLArray = [NSMutableArray array];
    _ZJTPArray = [NSMutableArray array];
    _ZJNameArray = [NSMutableArray array];
    _ZJURLArray = [NSMutableArray array];
    _YYTPArray = [NSMutableArray array];
    _YYNameArray = [NSMutableArray array];
    _YYURLArray = [NSMutableArray array];
    _HMArray = [NSMutableArray array];
    _TJArray = [NSMutableArray array];
    _SYArray = [NSMutableArray array];





    self.navigationItem.title = @"91助手";

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];

    [self requestData];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [_tableView registerClass:[RMTableViewCell class] forCellReuseIdentifier:@"cell"];

    [_tableView registerClass:[YYTableViewCell class] forCellReuseIdentifier:@"cell2"];

    //[_tableView registerNib:[UINib nibWithNibName:@"SYTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tiaozhaun:) name:@"shouye" object:nil];

    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(yingyong:) name:@"yingyong" object:nil];

}
//- (void)yingyong:(NSNotification *)index{
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"yingyong" object:nil];
//    NSString * url = index.userInfo[@"url"];
//
//    NSString * str = [NSString stringWithFormat:@"%@",self.YYNameArray];
//    scrollViewController * scroll = [[scrollViewController alloc]init];
//    scroll.targetUrl = url;
//    scroll.desc = str;
//    [self.navigationController pushViewController:scroll animated:YES];
//
//}
- (void)tiaozhaun:(NSNotification *)index{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sheouye" object:nil];
    NSString * url = index.userInfo[@"url"];
    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
    fl6.url = url;
    [self presentViewController:fl6 animated:YES completion:nil];

}
- (void)requestData{

    WeakSelf;
    //轮播图
    NSString * str = @"http://applebbx.sj.91.com/softs.ashx?adlt=1&spid=2&osv=9.3.4&places=1&imei=B28D2280-A1CF-4CC1-9D6E-46ED69D26E0E&dm=iPhone5,4&sv=3.1.3&act=222&pid=2&cuid=b922959a9c737e488a3ee95721bfaec501dea09c&nt=10&mt=1";
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSMutableArray * LBTArray = [NSMutableArray array];
        NSArray * array = responseObject[@"Result"];
        NSDictionary * dic = array[0];
        NSArray * array1 = dic[@"Value"];
        for (NSDictionary * dic1 in array1) {
            YBTModel * model = [[YBTModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [_LBTArray addObject:model];
            [LBTArray addObject:model.LogoUrl];
        }

        _scrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) imageURLStringsGroup:LBTArray];
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _scrollView.autoScroll = YES;
        _scrollView.delegate = self;
        _tableView.tableHeaderView = _scrollView;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

    //热门
    [_RMTPArray removeAllObjects];
    [_RMURLArray removeAllObjects];
    [_RMNameArray removeAllObjects];

    AFHTTPSessionManager * manager1 = [AFHTTPSessionManager manager];
    [manager1.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager1 GET:@"http://applebbx.sj.91.com/api/?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=708&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {

            [_RMTPArray addObject:dic1[@"icon"]];
            [_RMURLArray addObject:dic1[@"detailUrl"]];
            [_RMNameArray addObject:dic1[@"name"]];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

    //精品
    AFHTTPSessionManager * manager2 = [AFHTTPSessionManager manager];
    [manager2.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager2 GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=244&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=20&mt=1&nt=10&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {
            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.JPArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];


    //限时
    [_XSTPArray removeAllObjects];
    [_XSURLArray removeAllObjects];
    [_XSNameArray removeAllObjects];

    AFHTTPSessionManager * manager3 = [AFHTTPSessionManager manager];
    [manager3.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager3 GET:@"http://applebbx.sj.91.com/api/?act=246&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=15&mt=1&nt=10&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {

            [_XSTPArray addObject:dic1[@"icon"]];
            [_XSURLArray addObject:dic1[@"detailUrl"]];
            [_XSNameArray addObject:dic1[@"name"]];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    //装机
    [_ZJTPArray removeAllObjects];
    [_ZJURLArray removeAllObjects];
    [_ZJNameArray removeAllObjects];

    AFHTTPSessionManager * manager4 = [AFHTTPSessionManager manager];
    [manager4.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager4 GET:@"http://applebbx.sj.91.com/api/?act=236&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=15&mt=1&nt=10&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {

            [_ZJTPArray addObject:dic1[@"icon"]];
            [_ZJURLArray addObject:dic1[@"detailUrl"]];
            [_ZJNameArray addObject:dic1[@"name"]];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    //应用
    [_YYTPArray removeAllObjects];
    [_YYURLArray removeAllObjects];
    [_YYNameArray removeAllObjects];

    AFHTTPSessionManager * manager5 = [AFHTTPSessionManager manager];
    [manager5.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager5 GET:@"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=212&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = responseObject[@"Result"];
        //NSLog(@"asdasdasdasdasdasdasd%@",responseObject[@"Result"]);
        for (NSDictionary * dic1 in array) {

            [_YYTPArray addObject:dic1[@"icon"]];
            [_YYURLArray addObject:dic1[@"url"]];
            [_YYNameArray addObject:dic1[@"name"]];
            //NSLog(@"sdasdadsdas%@",_YYTPArray);
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    //黑马
    AFHTTPSessionManager * manager6 = [AFHTTPSessionManager manager];
    [manager6.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager6 GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=245&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=10&mt=1&nt=10&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {
            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.HMArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

    //编辑
    AFHTTPSessionManager * manager7 = [AFHTTPSessionManager manager];
    [manager7.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager7 GET:@"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=10.0.1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&imei=3B789F3A-937B-458E-947A-6C276B18A396&dm=iPhone8,1&sv=3.1.3&act=244&nt=10&pid=2&top=10" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"Result"];
        NSArray * array = dic[@"items"];
        for (NSDictionary * dic1 in array) {
            LBT2Model * model = [[LBT2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.TJArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

    //首页

    [_SYArray removeAllObjects];
    AFHTTPSessionManager * manager8 = [AFHTTPSessionManager manager];
    [manager8.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager8 GET:@"http://applebbx.sj.91.com/api/?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=1&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * array = responseObject[@"Result"];
        NSDictionary * dic = array[0];
        NSArray * array1 = dic[@"parts"];
        for (NSDictionary * dic1 in array1) {

            SYModel * model = [[SYModel alloc]init];
            [model setValuesForKeysWithDictionary:dic1];
            [self.SYArray addObject:model];
            //NSLog(@">>>>>>>>>>>>%@",self.SYArray);
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    SYModel * model = self.SYArray[section];
   // NSLog(@"sdasdasdasda%@",self.SYArray[section]);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor = [UIColor redColor];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
    _label.font = [UIFont systemFontOfSize:16];
    _label.text = model.name;
    [view addSubview:_label];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更多>" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(ScreenWidth - 60, 5, 50, 20);
    [button addTarget:self action:@selector(setbutton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 600 + section;
    [view addSubview:button];
    return view;

}
- (void)setbutton:(UIButton *)sender{

    //SYModel * model = [[SYModel alloc]init];
    scrollViewController * scr = [[scrollViewController alloc]init];
    YYViewController * yy = [[YYViewController alloc]init];
    if (sender.tag == 600) {
        scr.desc = @"热门应用";
        scr.targetUrl = @"http://applebbx.sj.91.com/api/?act=708&spid=2&pid=2&mt=1";
       [self.navigationController pushViewController:scr animated:YES];
    }else if (sender.tag == 601) {
        scr.desc = @"精品推荐";
        scr.targetUrl = @"http://applebbx.sj.91.com/soft/phone/list.aspx?act=244&top=20";
        [self.navigationController pushViewController:scr animated:YES];
    }else if (sender.tag == 602) {
        scr.desc = @"限时免费";
        scr.targetUrl = @"http://applebbx.sj.91.com/api/?act=246&spid=2&pid=2&mt=1&top=15";
        [self.navigationController pushViewController:scr animated:YES];
    }else if (sender.tag == 603) {
        scr.desc = @"装机必备";
        scr.targetUrl = @"http://applebbx.sj.91.com/api/?act=236&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&spid=2&imei=3B789F3A-937B-458E-947A-6C276B18A396&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
        [self.navigationController pushViewController:scr animated:YES];
    }else if (sender.tag == 604) {
        yy.desc = @"应用专题";
        yy.url = @"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=212&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&nt=10&mt=1&pid=2";
        [self.navigationController pushViewController:yy animated:YES];
    }else if (sender.tag == 605) {
        scr.desc = @"黑马闯入";
        scr.targetUrl = @"http://applebbx.sj.91.com/soft/phone/list.aspx?act=245&top=10";
        [self.navigationController pushViewController:scr animated:YES];
        //http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=1a820c0140c54e360821b62bfa489aced1443d5a&act=245&imei=3B789F3A-937B-458E-947A-6C276B18A396&spid=2&osv=10.0.1&dm=iPhone8,1&sv=3.1.3&top=10&mt=1&nt=10&pid=2
    }else if (sender.tag == 606) {
        scr.desc = @"编辑推荐";
        scr.targetUrl = @"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=10.0.1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&imei=3B789F3A-937B-458E-947A-6C276B18A396&dm=iPhone8,1&sv=3.1.3&act=244&nt=10&pid=2&top=10";
        [self.navigationController pushViewController:scr animated:YES];
        //http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=10.0.1&cuid=1a820c0140c54e360821b62bfa489aced1443d5a&imei=3B789F3A-937B-458E-947A-6C276B18A396&dm=iPhone8,1&sv=3.1.3&act=244&nt=10&pid=2&top=10
    }


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.SYArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3) {
        return 110;
    }else if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6){
        return 90;
    }else if (indexPath.section == 4){
        return 400;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0 || section == 2 || section == 3 || section == 4) {
        return 1;
    }else if (section == 1){
        return self.JPArray.count;
    }else if (section == 5){
        return self.HMArray.count;
    }else if (section == 6){
        return self.TJArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        RMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.tupian = self.RMTPArray;
        cell.url = self.RMURLArray;
        cell.name = self.RMNameArray;

        return cell;
    }else if (indexPath.section == 1){

        SYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SYTableViewCell class]) owner:self options:nil] firstObject];
        }else{
            while ([cell.contentView.subviews lastObject]!=nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.model = _JPArray[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){

        RMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.tupian = self.XSTPArray;
        cell.url = self.XSURLArray;
        cell.name = self.XSNameArray;

        return cell;

    }else if (indexPath.section == 3){

        RMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.tupian = self.ZJTPArray;
        cell.url = self.ZJURLArray;
        cell.name = self.ZJNameArray;

        return cell;
        
    }else if (indexPath.section == 4){

        YYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.tupian = self.YYTPArray;
        cell.url = self.YYURLArray;
        cell.name = self.YYNameArray;

        return cell;
        
    }else if (indexPath.section == 5){

        SYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SYTableViewCell class]) owner:self options:nil] firstObject];
        }else{
            while ([cell.contentView.subviews lastObject]!=nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.model = _HMArray[indexPath.row];
        return cell;
    }else if (indexPath.section == 6){

        SYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SYTableViewCell class]) owner:self options:nil] firstObject];
        }else{
            while ([cell.contentView.subviews lastObject]!=nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.model = _TJArray[indexPath.row];
        return cell;
    }
    return 0;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    YBTModel * model = _LBTArray[index];
    scrollViewController * scroll = [[scrollViewController alloc]init];
    scroll.desc = model.Desc;
    scroll.targetUrl = model.TargetUrl;
    [self.navigationController pushViewController:scroll animated:YES];
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
