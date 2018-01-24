//
//  LYExceedCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/24.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYExceedCell.h"
// Controllers

// Models
#import "LYWalletItem.h"
// Views
#import "LYWalletItemCell.h"
// Vendors
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
// Categories

// Others

@interface LYExceedCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//collection
@property(nonatomic, strong) UICollectionView *collectionView;
//模型数组
@property(nonatomic, strong) NSMutableArray<LYWalletItem *> *walletArr;

@end

static NSString *const LYWalletItemCellID = @"LYWalletItemCell";

@implementation LYExceedCell

#pragma mark - 懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ScreenW / 4, ScreenW / 4);
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenW / 4);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        //注册
        [_collectionView registerClass:[LYWalletItemCell class] forCellWithReuseIdentifier:LYWalletItemCellID];
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
    self.backgroundColor = RGB(62, 139, 251);
    self.collectionView.backgroundColor = self.backgroundColor;
}

#pragma mark - 数据
-(void)setUpData
{
    _walletArr = [LYWalletItem mj_objectArrayWithFilename:@"WalletGrid.plist"];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _walletArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYWalletItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYWalletItemCellID forIndexPath:indexPath];
    cell.gridItem = _walletArr[indexPath.row];
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
