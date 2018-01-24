//
//  LYMessageModel.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/11.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYMessageModel : NSObject
//标题
@property(nonatomic, strong) NSString *Title;
//内容
@property(nonatomic, strong) NSString *Content;
//时间
@property(nonatomic, strong) NSString *Senddata;

@end
