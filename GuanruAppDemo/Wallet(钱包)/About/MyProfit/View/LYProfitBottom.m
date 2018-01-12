//
//  LYProfitBottom.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYProfitBottom.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYProfitBottom ()
//金额名称
@property(nonatomic, strong) UILabel *titleLabel;
//当前可提现分润
@property(nonatomic, strong) UILabel *indicatorLabel;
//我要结算
@property(nonatomic, strong) UIButton *accountBtn;

@end

@implementation LYProfitBottom

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
    self.backgroundColor = RGBA(50, 112, 229, 1.0);
    //设置圆角幅度
//    self.layer.cornerRadius = 8.0;
//    self.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:35.0];
    _titleLabel.text = @"￥";
    [self addSubview:_titleLabel];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.font = [UIFont systemFontOfSize:35.0];
    _numLabel.text = @"0.00";
    [self addSubview:_numLabel];
    
    _indicatorLabel = [[UILabel alloc] init];
    _indicatorLabel.textColor = [UIColor whiteColor];
    _indicatorLabel.font = PFR16Font;
    _indicatorLabel.text = @"账户余额(元)  | ";
    _indicatorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_indicatorLabel];
    
    _accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_accountBtn setBackgroundImage:[UIImage imageNamed:@"提现"] forState:0];
    _accountBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_accountBtn];
    
    [_accountBtn addTarget:self action:@selector(accountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    _bottomImgView = [[UIImageView alloc] init];
//    _bottomImgView.image = [UIImage imageNamed:@"弧形"];
//    [self addSubview:_bottomImgView];
    
    _totalMoney = [[UILabel alloc] init];
    _totalMoney.textColor = [UIColor whiteColor];
    [self addSubview:_totalMoney];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.equalTo(15);
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.right).offset(3);
        make.top.equalTo(15);
//        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_indicatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left).offset(0);
        make.top.equalTo(_numLabel.bottom).offset(4);
//        make.size.equalTo(CGSizeMake(150, 35));
    }];
    
    [_accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_indicatorLabel.centerY);
        make.left.equalTo(_indicatorLabel.right).offset(DCMargin);
        make.size.equalTo(CGSizeMake(70, 25));
    }];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_indicatorLabel.bottom).offset(5);
        make.left.equalTo(_indicatorLabel.left);
    }];
    
//    [_bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(0);
//        make.left.right.equalTo(0);
//        make.height.equalTo(25);
//    }];
    
}

#pragma mark - Setter Getter Methods


#pragma mark - 点击事件
-(void)accountBtnClick
{
    if ([_numLabel.text doubleValue] <= 0.00)
    {
        [DCSpeedy alertMes:@"没有可结算金额！"];
    }
    else
    {
        !_accountBtnClickBlock  ? : _accountBtnClickBlock();
    }
}

@end
