//
//  LYFacePayCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYFacePayCell : UITableViewCell
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//textField
@property(nonatomic, strong) UITextField *textField;
//判断是那种cell
@property(nonatomic, assign) BOOL flag;

@end
