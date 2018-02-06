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
//冻结账户
@property(nonatomic, strong) UILabel *freezeLabel;


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
    
//    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.textColor = [UIColor whiteColor];
//    _titleLabel.font = [UIFont systemFontOfSize:35.0];
//    _titleLabel.text = @"￥";
//    [self addSubview:_titleLabel];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.font = [UIFont systemFontOfSize:35.0];
    _numLabel.text = @"0.00";
    [self addSubview:_numLabel];
    
    _indicatorLabel = [[UILabel alloc] init];
    _indicatorLabel.textColor = [UIColor whiteColor];
    _indicatorLabel.font = PFR16Font;
    _indicatorLabel.text = @"账户余额(元)";
    _indicatorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_indicatorLabel];
    
    _accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_accountBtn setTitle:@"提现" forState:0];
    _accountBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_accountBtn];
    
    [_accountBtn addTarget:self action:@selector(accountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    _bottomImgView = [[UIImageView alloc] init];
//    _bottomImgView.image = [UIImage imageNamed:@"弧形"];
//    [self addSubview:_bottomImgView];
    
    _totalMoney = [[UILabel alloc] init];
    _totalMoney.textColor = [UIColor whiteColor];
    [self addSubview:_totalMoney];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = RGB(37, 124, 225);
    [self addSubview:_bottomView];
    
    _freezeLabel = [[UILabel alloc] init];
    _freezeLabel.text = @"冻结账户";
    _freezeLabel.font = PFR15Font;
    _freezeLabel.textColor = [UIColor whiteColor];
    [self.bottomView addSubview:_freezeLabel];
    
    _freezeMoneyLabel = [[UILabel alloc] init];
    _freezeMoneyLabel.textColor = [UIColor whiteColor];
    _freezeMoneyLabel.font = PFR18Font;
//    _freezeMoneyLabel.text = @"0.00";
    [self.bottomView addSubview:_freezeMoneyLabel];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(15);
//        make.left.equalTo(15);
//    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(15);
//        make.size.equalTo(CGSizeMake(100, 35));
    }];
    
    [_indicatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(_numLabel.bottom).offset(4);
//        make.size.equalTo(CGSizeMake(150, 35));
    }];
    
    [_accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_indicatorLabel.bottom).offset(15);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(35);
    }];
    [DCSpeedy dc_chageControlCircularWith:_accountBtn AndSetCornerRadius:8 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountBtn.bottom).offset(10);
        make.right.equalTo(-5);
    }];
    
//    [_bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(0);
//        make.left.right.equalTo(0);
//        make.height.equalTo(25);
//    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(30);
    }];
    
    [_freezeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.left).offset(5);
        make.bottom.equalTo(_bottomView.bottom).offset(0);
        make.height.equalTo(30);
    }];
    
    [_freezeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.right).offset(-5);
        make.bottom.equalTo(_bottomView.bottom).offset(0);
        make.height.equalTo(30);
    }];
    
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
