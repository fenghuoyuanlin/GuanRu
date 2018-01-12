//
//  LYRateItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRateItem : NSObject
//费率
@property(nonatomic, strong) NSString *rate;
//结算
@property(nonatomic, strong) NSString *account;
//额度
@property(nonatomic, strong) NSString *amount;
//品牌
@property(nonatomic, strong) NSString *brand;

@property(nonatomic, strong) NSString *img;

@end
