//
//  LYBottomCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/24.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^leftBlockAction)(NSIndexPath *indexPath);
@interface LYBottomCell : UICollectionViewCell

//点击事件
@property(nonatomic, copy) leftBlockAction itemBlock;

@end
