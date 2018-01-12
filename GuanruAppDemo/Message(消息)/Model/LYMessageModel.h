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
@property(nonatomic, strong) NSString *title;
//图片
@property(nonatomic, strong) NSString *imageName;
//消息
@property(nonatomic, strong) NSString *message;

@end
