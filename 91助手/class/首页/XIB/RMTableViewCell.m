//
//  RMTableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/13.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "RMTableViewCell.h"
#import "RMCollectionViewCell.h"
#import "FL6ViewController.h"
@interface RMTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView * collection;
@end
@implementation RMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.collection];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UICollectionView *)collection{

    if (!_collection) {

        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(65, 90);
        flowLayout.minimumLineSpacing = 30;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 90) collectionViewLayout:flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerNib:[UINib nibWithNibName:@"RMCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    }
    return _collection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.tupian.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RMCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageUrl = self.tupian[indexPath.item];
    cell.label = self.name[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"shouye" object:self userInfo:@{@"url":self.url[indexPath.item]}];
//    id object = [self nextResponder];
//    while (![object isKindOfClass:[UIViewController class]] &&
//           object != nil) {
//        object = [object nextResponder];
//    }
//    UIViewController *uc=(UIViewController*)object;
//    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
//    fl6.url = _url[indexPath.item];
//    //fl6.text = _tupian[indexPath.item];
//    fl6.hidesBottomBarWhenPushed = YES;
//    [uc.navigationController pushViewController:fl6 animated:YES];

}
- (void)setTupian:(NSArray *)tupian{
    _tupian = tupian;
    [self.collection reloadData];
}
- (void)setUrl:(NSArray *)url{
    _url = url;
    [self.collection reloadData];
}
- (void)setName:(NSArray *)name{
    _name = name;
    [self.collection reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
