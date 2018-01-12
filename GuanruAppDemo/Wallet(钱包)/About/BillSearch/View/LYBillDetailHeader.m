//
//  LYBillDetailHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillDetailHeader.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYBillDetailHeader ()

//标题
@property(nonatomic, strong) UILabel *titleLabel;
//时间
@property(nonatomic, strong) UILabel *infoLabel;
//下划线
@property(nonatomic, strong) UIView *lineView;

@end

@implementation LYBillDetailHeader

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
    self.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"交易金额";
//    _titleLabel.textColor = RGB(97, 98, 99);
    [self addSubview:_titleLabel];
    
    _moneyUpLabel = [[UILabel alloc] init];
    [self addSubview:_moneyUpLabel];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = DCBGColor;
    [self addSubview:_lineView];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.left.equalTo(DCMargin);
    }];
    
    [_moneyUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.bottom.equalTo(-15);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(DCMargin);
        make.right.equalTo(-DCMargin);
        make.height.equalTo(2);
    }];
}



@end
