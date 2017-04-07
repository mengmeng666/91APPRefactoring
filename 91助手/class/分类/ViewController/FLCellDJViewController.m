//
//  FLCellDJViewController.m
//  🐂X壁纸
//
//  Created by 董晓萌 on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "FLCellDJViewController.h"
#import "FL2ViewController.h"
#import "FL3ViewController.h"
#import "FL4ViewController.h"
#import "FL5ViewController.h"

@interface FLCellDJViewController ()<UIScrollViewDelegate>

//按钮父视图
@property (nonatomic,strong)UIView * buttonsView;
//按钮子视图
@property (nonatomic,strong)UIScrollView * scrollView;
//底部条
@property (nonatomic,strong)UIView * bottomView;
//选中的按钮
@property (nonatomic,strong)UIButton * selectedButton;
@property (nonatomic,strong)NSMutableArray * buttonsArray;

@end

static NSString * coll = @"collection";
@implementation FLCellDJViewController

- (NSMutableArray *)buttonsArray{

    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.name;

    [self setupChildVcs];

    [self setupScrollView];

    [self setButtonsView];

    // Do any additional setup after loading the view.
}
//父视图
- (void)setButtonsView{

    UIView * buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    buttonsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonsView];
    self.buttonsView = buttonsView;

    NSInteger count = self.childViewControllers.count;
    CGFloat buttonsViewH = buttonsView.height;
    CGFloat buttonsViewW = buttonsView.width / count;
    for (int i = 0; i < count; i++) {

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:255 / 256.0 green:193 / 256.0 blue:77 / 256.0 alpha:1]forState:UIControlStateSelected];
        button.tag=100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];

        [button addTarget:self action:@selector(setButton:) forControlEvents:UIControlEventTouchUpInside];

        [buttonsView addSubview:button];
        [self.buttonsArray addObject:button];

        //文字
        NSString * title = [self.childViewControllers[i]title];
        [button setTitle:title forState:UIControlStateNormal];
        //frame
        button.y = 0;
        button.height = buttonsViewH;
        button.width = buttonsViewW;
        button.x = i * button.width;
    }
        //条
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [self.buttonsArray.lastObject titleColorForState:UIControlStateSelected];
        bottomView.height = 1;
        bottomView.y = buttonsView.height - bottomView.height;
        [buttonsView addSubview:bottomView];
        self.bottomView = bottomView;

        // 默认点击最前面的按钮
        UIButton * qianButton = self.buttonsArray.firstObject;
        [qianButton.titleLabel sizeToFit];
        bottomView.width = qianButton.titleLabel.width;
        bottomView.centerX = qianButton.centerX;

        [self setButton:qianButton];

}

//监听
- (void)setButton:(UIButton *)titleButton{

    // 控制按钮状态
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.width = titleButton.titleLabel.width;
        self.bottomView.centerX = titleButton.centerX;
    }];

    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.buttonsArray indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];

    if (titleButton.tag == 101) {

        
    }
}

- (void)setupScrollView{

    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    [self.view addSubview:_scrollView];
    
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:_scrollView];

}

- (void)setupChildVcs{

    FL2ViewController * fl2 = [[FL2ViewController alloc]init];
    fl2.title = @"免费应用";
    fl2.fl2model = self.fl2model;
    [self addChildViewController:fl2];

    FL3ViewController * fl3 = [[FL3ViewController alloc]init];
    fl3.title = @"限时免费";
    fl3.fl2model = self.fl2model;
    [self addChildViewController:fl3];

    FL4ViewController * fl4 = [[FL4ViewController alloc]init];
    fl4.title = @"降价应用";
    fl4.fl2model = self.fl2model;
    [self addChildViewController:fl4];

    FL5ViewController * fl5 = [[FL5ViewController alloc]init];
    fl5.title = @"收费应用";
    fl5.fl2model = self.fl2model;
    [self addChildViewController:fl5];
}

/**
 * 当滚动动画完 毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / ScreenWidth;
    UIViewController * childVc = self.childViewControllers[index];
    // 如果控制器的view已经被创建过，就直接返回
    if (childVc.isViewLoaded)return;
    // 添加子控制器的view到scrollView身上
    childVc.view.frame = scrollView.bounds;

    [scrollView addSubview:childVc.view];
}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];

    //点击按钮
    int index = scrollView.contentOffset.x / scrollView.width;
    [self setButton:self.buttonsArray[index]];
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
