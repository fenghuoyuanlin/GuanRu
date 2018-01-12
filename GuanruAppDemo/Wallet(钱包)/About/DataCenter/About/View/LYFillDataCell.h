//
//  LYFillDataCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/21.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYRegisterItem;
@interface LYFillDataCell : UITableViewCell

//消息模型
@property(nonatomic, strong) LYRegisterItem *registerItem;
//textField
@property(nonatomic, strong) UITextField *textField;
//内容
@property(nonatomic, strong) UILabel *contentLabel;
//判断是那种cell
@property(nonatomic, assign) BOOL flag;

@end
