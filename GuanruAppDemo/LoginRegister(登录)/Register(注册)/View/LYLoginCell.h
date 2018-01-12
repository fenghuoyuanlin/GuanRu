//
//  LYLoginCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/4.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYRegisterItem;
@interface LYLoginCell : UITableViewCell
//消息模型
@property(nonatomic, strong) LYRegisterItem *registerItem;
//textField
@property(nonatomic, strong) UITextField *textField;

@end
