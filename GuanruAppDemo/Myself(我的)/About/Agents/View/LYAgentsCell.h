//
//  LYAgentsCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/14.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYAgentItem;
@interface LYAgentsCell : UITableViewCell
//数据模型
@property(nonatomic, strong) LYAgentItem *agentItem;

/** 删除点击事件 */
@property (nonatomic, copy) dispatch_block_t editBtnClickBlock;

@end
