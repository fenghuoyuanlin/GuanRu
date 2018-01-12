//
//  LYTopLineFootView.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/7/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTopLineFootView : UICollectionReusableView

/** 收款按钮点击事件 */
@property (nonatomic, copy) dispatch_block_t questionClickBlock;

@end
