//
//  LYAccountItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYAccountItem : NSObject
//标题
@property(nonatomic, strong) NSString *title;
//图片
@property(nonatomic, strong) NSString *imageName;
//关联
@property(nonatomic, strong) NSString *info;
//内容
@property(nonatomic, strong) NSString *content;

@end
