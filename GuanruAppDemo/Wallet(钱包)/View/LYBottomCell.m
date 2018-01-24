//
//  LYBottomCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/24.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYBottomCell.h"
// Controllers

// Models
#import "LYCardItem.h"
// Views
#import "LYRecommendCell.h"
// Vendors
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
// Categories

// Others

@interface LYBottomCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//collection
@property(nonatomic, strong) UICollectionView *collectionView;
//模型数组
@property(nonatomic, strong) NSMutableArray<LYCardItem *> *cardArr;

@end

static NSString *const LYRecommendCellID = @"LYRecommendCell";

@implementation LYBottomCell

#pragma mark - 懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = (iphone5) ? CGSizeMake((ScreenW - 20 - 15) / 2, 70) : CGSizeMake((ScreenW - 20 - 15) / 2, 90);
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = 15;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.frame = (iphone5) ? CGRectMake(DCMargin, 0, ScreenW - 2 * DCMargin, 70) : CGRectMake(DCMargin, 0, ScreenW - 2 * DCMargin, 90);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        //注册
        [_collectionView registerClass:[LYRecommendCell class] forCellWithReuseIdentifier:LYRecommendCellID];
    }
    return _collectionView;
}

#pragma mark - Intial
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpData];
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}

#pragma mark - 数据
-(void)setUpData
{
    _cardArr = [LYCardItem mj_objectArrayWithFilename:@"CardItem.plist"];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cardArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYRecommendCellID forIndexPath:indexPath];
    cell.cardItem = _cardArr[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
    if (_itemBlock)
    {
        self.itemBlock(indexPath);
    }
}


@end
