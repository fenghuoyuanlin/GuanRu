//
//  LYDayItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/13.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYBillItem;
@interface LYDayItem : NSObject
//日期天数
@property(nonatomic, strong) NSString *dayStr;
//对应的数组模型
@property(nonatomic, strong) NSMutableArray<LYBillItem *> *listArr;

@end
