//
//  LYMessageItem.h
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/7/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYMessageItem : NSObject
//标题
@property(nonatomic, strong) NSString *title;
//图片
@property(nonatomic, strong) NSString *imageName;
//消息
@property(nonatomic, strong) NSString *message;

@end
