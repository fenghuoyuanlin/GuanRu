//
//  LYCardItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/23.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCardItem : NSObject
//图片
@property(nonatomic, strong) NSString *iconImage;
//文字
@property(nonatomic, strong) NSString *gridTitle;
//详情
@property(nonatomic, strong) NSString *info;

@end
