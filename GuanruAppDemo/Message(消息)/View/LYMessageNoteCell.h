//
//  LYMessageNoteCell.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/8/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYMessageItem;
@interface LYMessageNoteCell : UITableViewCell
//消息模型
@property(nonatomic, strong) LYMessageItem *messageItem;

@end
