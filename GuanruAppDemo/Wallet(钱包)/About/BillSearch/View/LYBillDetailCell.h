//
//  LYBillDetailCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYBillDetail;
@interface LYBillDetailCell : UITableViewCell
//账单模型
@property(nonatomic, strong) LYBillDetail *billDetailItem;

@property(nonatomic, strong) UILabel *infoLabel;

@end
