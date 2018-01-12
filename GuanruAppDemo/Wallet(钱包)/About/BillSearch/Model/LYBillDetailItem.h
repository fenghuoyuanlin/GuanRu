//
//  LYBillDetailItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYBillDetailItem : NSObject
//标题
@property(nonatomic, strong) NSString *Data;
//内容
@property(nonatomic, strong) NSString *Status;

@property(nonatomic, strong) NSString *code;

@property(nonatomic, strong) NSString *msg;

@property(nonatomic, strong) NSString *tradeAmount;

@property(nonatomic, strong) NSString *tradeNum;

@end
