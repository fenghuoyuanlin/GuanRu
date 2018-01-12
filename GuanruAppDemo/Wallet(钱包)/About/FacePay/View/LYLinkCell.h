//
//  LYLinkCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYLinkItem;
@interface LYLinkCell : UITableViewCell

//消息模型
@property(nonatomic, strong) LYLinkItem *linkItem;

/** 打开点击事件 */
@property (nonatomic, copy) dispatch_block_t openClickBlock;
/** 删除点击事件 */
@property (nonatomic, copy) dispatch_block_t delegateBtnClickBlock;

@end
