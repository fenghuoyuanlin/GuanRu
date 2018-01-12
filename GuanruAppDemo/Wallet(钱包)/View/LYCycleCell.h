//
//  LYCycleCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCycleCell : UICollectionViewCell
/** 轮播图片点击事件 */
@property (nonatomic, copy) dispatch_block_t cycleImageClickBlock;

@end
