//
//  LYCustionHeadView.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/8/10.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCustionHeadView : UICollectionReusableView
//推荐点击回调
@property(nonatomic, copy) dispatch_block_t recommendClickBlock;
//价格点击回调
@property(nonatomic, copy) dispatch_block_t priceClickBlock;
//销量点击回调
@property(nonatomic, copy) dispatch_block_t salesClickBlock;
//推荐点击回调
@property(nonatomic, copy) dispatch_block_t filtrateClickBlock;
//重复点击回调
@property(nonatomic, copy) dispatch_block_t repeatClickBlock;

@end
