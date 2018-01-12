//
//  NSObject+Property.h
//  Runtime(字典转模型KVC实现)
//
//  Created by 李翔宇 on 16/10/6.
//  Copyright © 2016年 李翔宇 All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;


@end
