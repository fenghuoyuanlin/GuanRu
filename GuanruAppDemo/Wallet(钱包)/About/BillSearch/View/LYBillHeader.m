
//
//  LYBillHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillHeader.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYBillHeader ()
//背景图片
@property(nonatomic, strong) UIImageView *backgroundView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//时间
@property(nonatomic, strong) UILabel *infoLabel;
//下划线
@property(nonatomic, strong) UIView *lineView;

@end

@implementation LYBillHeader

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
    self.backgroundColor = [UIColor clearColor];
    
    _backgroundView = [[UIImageView alloc] init];
    _backgroundView.image = [UIImage imageNamed:@"kuang"];
    [self addSubview:_backgroundView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"今日交易金额";
    _titleLabel.textColor = RGB(0, 135, 241);
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = @"今日交易笔数";
    _infoLabel.textColor = RGB(0, 135, 241);
    [self addSubview:_infoLabel];
    
    _moneyUpLabel = [[UILabel alloc] init];
    _moneyUpLabel.font = [UIFont systemFontOfSize:22.0];
    _moneyUpLabel.textColor = [UIColor blackColor];
    _moneyUpLabel.text = @"0笔";
    [self addSubview:_moneyUpLabel];
    
    _moneyBottomLabel = [[UILabel alloc] init];
    _moneyBottomLabel.font = [UIFont systemFontOfSize:22.0];
    _moneyBottomLabel.textColor = [UIColor blackColor];
    _moneyBottomLabel.text = @"0.00";
    [self addSubview:_moneyBottomLabel];
    
    
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(2*DCMargin);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.right.equalTo(-2*DCMargin);
    }];
    
    [_moneyBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_titleLabel.centerX);
        make.top.equalTo(_titleLabel.bottom).offset(15);
    }];
    
    [_moneyUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_infoLabel.centerX);
        make.top.equalTo(_infoLabel.bottom).offset(15);
    }];
    
}


@end
