//
//  LYProfitBottom.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYProfitBottom : UIView

//numLabel
@property(nonatomic, strong) UILabel *numLabel;
//总金额
@property(nonatomic, strong) UILabel *totalMoney;

/** 结算按钮点击事件 */
@property (nonatomic, copy) dispatch_block_t accountBtnClickBlock;

@end
