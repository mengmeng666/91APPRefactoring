//
//  FL4TableViewCell.m
//  91助手
//
//  Created by 董晓萌 on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "FL4TableViewCell.h"
#import "FL5CollectionViewCell.h"
#import "FL6ViewController.h"
NSString * const TONGZHI = @"TONGZHI";

@interface FL4TableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collection;

@property (nonatomic,strong)UILabel * label;

@end
@implementation FL4TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collection];
        [self.contentView addSubview:self.label];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];

}
- (UICollectionView *)collection{

    if (!_collection) {

        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(60, 60);
        flowLayout.minimumLineSpacing = 30;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 40, ScreenWidth - 20, 70) collectionViewLayout:flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerNib:[UINib nibWithNibName:@"FL5CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    }
    return _collection;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 250, 30)];
        _label.text = @"下载此应用的人也下载了";
        _label.font = [UIFont systemFontOfSize:17];
    }
    return _label;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"sssssssssssssssss%@",self.TPArray);

    return self.TPArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FL5CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.arrayUrl = self.TPArray[indexPath.item];
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [[NSNotificationCenter defaultCenter]postNotificationName:TONGZHI object:self userInfo:@{@"url":self.arryaUrl[indexPath.item]}];

//    FL6ViewController * fl6 = [[FL6ViewController alloc]init];
//    fl6.url = self.arryaUrl[indexPath.item];
//    [self.window.rootViewController presentViewController:fl6 animated:YES completion:nil];

}

- (void)setTPArray:(NSMutableArray *)TPArray{
    _TPArray = TPArray;
    //NSLog(@">>>>>>>%@",_TPArray);
    [self.collection reloadData];
}

- (void)setArryaUrl:(NSMutableArray *)arryaUrl{
    _arryaUrl = arryaUrl;
    [self.collection reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
