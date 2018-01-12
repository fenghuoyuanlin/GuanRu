//
//  LYWithDetailItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWithDetailItem : NSObject

//支付宝账号
@property(nonatomic, strong) NSString *aliAcount;
//金额
@property(nonatomic, strong) NSString *money;
//日期
@property(nonatomic, strong) NSString *date;
//提示字符串
@property(nonatomic, strong) NSString *indicator;

@property(nonatomic, strong) NSString *accountType;

@property(nonatomic, strong) NSString *agentid;

@property(nonatomic, strong) NSString *amt;

@property(nonatomic, strong) NSString *balanceType;

@property(nonatomic, strong) NSString *createTime;

@property(nonatomic, strong) NSString *currBalanceAmt;

@property(nonatomic, strong) NSString *fenrunType;

@property(nonatomic, strong) NSString *id;

@property(nonatomic, strong) NSString *status;

@property(nonatomic, strong) NSString *tradeAmt;

@end
