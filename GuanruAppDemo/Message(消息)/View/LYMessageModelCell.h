//
//  LYMessageModelCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/11.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYMessageModel;
@interface LYMessageModelCell : UITableViewCell

//消息模型
@property(nonatomic, strong) LYMessageModel *messageItem;

@end
