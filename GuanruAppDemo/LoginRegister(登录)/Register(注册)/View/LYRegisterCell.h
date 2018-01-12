//
//  LYRegisterCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/20.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYRegisterItem;
@interface LYRegisterCell : UITableViewCell
//消息模型
@property(nonatomic, strong) LYRegisterItem *registerItem;
//textField
@property(nonatomic, strong) UITextField *textField;

@end
