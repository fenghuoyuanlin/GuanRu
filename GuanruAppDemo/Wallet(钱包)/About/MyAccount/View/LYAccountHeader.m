//
//  LYAccountHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYAccountHeader.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYAccountHeader ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//内容
@property(nonatomic, strong) UILabel *infoLabel;

@end

@implementation LYAccountHeader

#pragma mark - initial
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
    self.backgroundColor = RGBA(66, 195, 234, 1.0);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR20Font;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"0";
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = PFR14Font;
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.text = @"商户数(个)";
    [self addSubview:_infoLabel];
    
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.centerX.equalTo(self);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleLabel.bottom).offset(DCMargin);
    }];
    
}

@end
