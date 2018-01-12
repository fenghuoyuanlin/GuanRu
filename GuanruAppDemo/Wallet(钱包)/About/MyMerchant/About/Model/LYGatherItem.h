//
//  LYGatherItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYGatherItem : NSObject
//收款
@property(nonatomic, strong) NSString *accountType;
//日期
@property(nonatomic, strong) NSString *agentid;
//余额
@property(nonatomic, strong) NSString *amt;
//金钱
@property(nonatomic, strong) NSString *balanceType;
//收款
@property(nonatomic, strong) NSString *createTime;
//日期
@property(nonatomic, strong) NSString *currBalanceAmt;
//余额
@property(nonatomic, strong) NSString *id;
//金钱
@property(nonatomic, strong) NSString *status;

@property(nonatomic, strong) NSString *tradeAmt;

@end
