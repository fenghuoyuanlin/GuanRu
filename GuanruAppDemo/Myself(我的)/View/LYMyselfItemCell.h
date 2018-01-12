//
//  LYMyselfItemCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYMyselfItem;
@interface LYMyselfItemCell : UITableViewCell
//自我模型
@property(nonatomic, strong) LYMyselfItem *myselfItem;

//消息
@property(nonatomic, strong) UILabel *messageLabel;

@end
