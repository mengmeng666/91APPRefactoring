//
//  YYTableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "YYTableViewCell.h"
#import "YYCollectionViewCell.h"
#import "scrollViewController.h"
@interface YYTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView * collection;

@end
@implementation YYTableViewCell

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
        flowLayout.itemSize = CGSizeMake(ScreenWidth - 2 * 10 , 155);
        //flowLayout.minimumLineSpacing = 10;
        //flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 390) collectionViewLayout:flowLayout];
        //_collection.contentSize = CGSizeMake(ScreenWidth, 900);
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
       // _collection.bounces = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerNib:[UINib nibWithNibName:@"YYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    }
    return _collection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.tupian.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    YYCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageUrl = self.tupian[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //[[NSNotificationCenter defaultCenter]postNotificationName:@"yingyong" object:@"" userInfo:@{@"url":self.url[indexPath.item]}];

    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    UIViewController *uc=(UIViewController*)object;
    scrollViewController * scroll = [[scrollViewController alloc]init];
    scroll.desc = self.name[indexPath.item];
    scroll.targetUrl = self.url[indexPath.item];
    [uc.navigationController pushViewController:scroll animated:YES];

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
