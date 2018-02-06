//
//  LYAgentItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/14.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAgentItem : NSObject

@property(nonatomic, strong) NSString *merchant_name;

@property(nonatomic, strong) NSString *createTime;

@property(nonatomic, strong) NSString *rate_value;

@property(nonatomic, strong) NSString *id;
//大额费率
@property(nonatomic, strong) NSString *large_value;
//信用卡费率
@property(nonatomic, strong) NSString *credit_value;

@end
