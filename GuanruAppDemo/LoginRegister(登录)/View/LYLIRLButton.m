//
//  LYLIRLButton.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/22.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYLIRLButton.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYLIRLButton ()


@end

@implementation LYLIRLButton

#pragma mark - inital
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.dc_centerX = self.dc_width * 0.6;
    self.imageView.dc_x = self.titleLabel.dc_x - self.imageView.dc_width - 5
    ;
}

#pragma mark - Setter Getter Methods


@end

