//
//  LYServiceItem.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/23.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYServiceItem : NSObject
//标题
@property(nonatomic, strong) NSString *gridTitle;
//图片
@property(nonatomic, strong) NSString *iconImage;
//内容
@property(nonatomic, strong) NSString *info;

@end
