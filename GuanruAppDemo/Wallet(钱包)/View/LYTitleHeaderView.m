//
//  LYTitleHeaderView.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/22.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYTitleHeaderView.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYTitleHeaderView ()


@end

@implementation LYTitleHeaderView

#pragma mark - Intial
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleBtn.titleLabel.font = PFR15Font;
    [_titleBtn setTitle:@"精选信息" forState:0];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:0];
    [self addSubview:_titleBtn];
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark Setter Getter Methods


@end
