//
//  SubmitBtn.m
//  HengShuaTest
//
//  Created by 刘园 on 2017/12/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "SubmitBtn.h"
/**
 *  button颜色
 */
#define ButtonColor [UIColor colorWithRed:253.0 / 255.0 green:182.0 / 255.0 blue:21.0/255.0 alpha:1.0]
@implementation SubmitBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:44*m6Scale];
        self.backgroundColor = ButtonColor;
        self.layer.cornerRadius = 5;
    }
    return self;
}


@end
