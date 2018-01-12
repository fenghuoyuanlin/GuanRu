//
//  LYProfitHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYProfitHeader.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYProfitHeader ()
//昨日收益
@property(nonatomic, strong) UILabel *yesterdayLabel;
//今日收益
@property(nonatomic, strong) UILabel *todayLabel;
//金额数量
@property(nonatomic, strong) UILabel *numLabelOne;
//金额数量
@property(nonatomic, strong) UILabel *numLabelTwo;
//竖线
@property(nonatomic, strong) UIView *verLine;

@end

@implementation LYProfitHeader

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
    
    _numLabelOne = [[UILabel alloc] init];
    _numLabelOne.font = PFR18Font;
    _numLabelOne.textColor = [UIColor whiteColor];
    _numLabelOne.text = @"0.00";
    _numLabelOne.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numLabelOne];
    
    _numLabelTwo = [[UILabel alloc] init];
    _numLabelTwo.font = PFR18Font;
    _numLabelTwo.textColor = [UIColor whiteColor];
    _numLabelTwo.text = @"0.00";
    _numLabelTwo.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numLabelTwo];
    
    _yesterdayLabel = [[UILabel alloc] init];
    _yesterdayLabel.font = PFR14Font;
    _yesterdayLabel.textColor = [UIColor whiteColor];
    _yesterdayLabel.text = @"昨日收益(元)";
    _yesterdayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_yesterdayLabel];
    
    _todayLabel = [[UILabel alloc] init];
    _todayLabel.font = PFR14Font;
    _todayLabel.textColor = [UIColor whiteColor];
    _todayLabel.text = @"今日收益(元)";
    _todayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_todayLabel];
    
    _verLine = [UIView new];
    _verLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:_verLine];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_numLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.top.equalTo(44);
        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.top.equalTo(_numLabelOne.bottom).offset(5);
        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_numLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-40);
        make.top.equalTo(44);
        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-40);
        make.top.equalTo(_numLabelTwo.bottom).offset(5);
        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(54);
        make.size.equalTo(CGSizeMake(1, 35));
    }];
    
}

#pragma mark - Setter Getter Methods

@end
