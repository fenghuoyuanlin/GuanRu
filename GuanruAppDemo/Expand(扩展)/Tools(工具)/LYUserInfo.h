//
//  LYUserInfo.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/8/2.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"
@interface LYUserInfo : JKDBModel

@property(nonatomic, strong) NSString *sex;

@property(nonatomic, strong) NSString *username;

@property(nonatomic, strong) NSString *nickname;

@property(nonatomic, strong) NSString *userimage;

@property(nonatomic, strong) NSString *birthDay;

@property(nonatomic, strong) NSString *defaultAddress;

@property(nonatomic, strong) NSString *agent_no;

@property(nonatomic, strong) NSString *userid;

@property(nonatomic, strong) NSString *phone;

@property(nonatomic, strong) NSString *alipayaccount;

@end
