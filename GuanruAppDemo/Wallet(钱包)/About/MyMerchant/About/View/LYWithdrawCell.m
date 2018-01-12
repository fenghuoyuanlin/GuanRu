//
//  LYWithdrawCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYWithdrawCell.h"
// Controllers

// Models
#import "LYWithdrowItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYWithdrawCell ()
//头部图片
@property(nonatomic, strong) UIImageView *titleImgView;
//支付宝账号
@property(nonatomic, strong) UILabel *aliLabel;
//日期
@property(nonatomic, strong) UILabel *dateLabel;
//提示Label
@property(nonatomic, strong) UILabel *indicatorLabel;
//金额
@property(nonatomic, strong) UILabel *moneyLabel;

@end

@implementation LYWithdrawCell

#pragma mark - inital
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _titleImgView = [[UIImageView alloc] init];
    
    [self addSubview:_titleImgView];
    
    _aliLabel = [[UILabel alloc] init];
    _aliLabel.text = @"支付宝";
    _aliLabel.font = PFR18Font;
    [self addSubview:_aliLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = PFR14Font;
    _dateLabel.textColor = RGB(159, 160, 161);
    [self addSubview:_dateLabel];
    
    _indicatorLabel = [[UILabel alloc] init];
    _indicatorLabel.font = PFR14Font;
    [self addSubview:_indicatorLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = PFR18Font;
    [self addSubview:_moneyLabel];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImgView.right).offset(DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_aliLabel.bottom).offset(7);
        make.left.equalTo(_titleImgView.right).offset(DCMargin);
    }];

    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.right.equalTo(-DCMargin);
    }];
    
    [_indicatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.top.equalTo(_moneyLabel.bottom).offset(7);
    }];
    
}

#pragma mark - Setter Getter Methods

-(void)setWithdrowItem:(LYWithdrowItem *)withdrowItem
{
    _withdrowItem = withdrowItem;

    _titleImgView.image = [UIImage imageNamed:@"zfb"];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f", [withdrowItem.amt doubleValue]];
    _dateLabel.text = [DCSpeedy timeStampToStr:withdrowItem.createTime];
    
    if ([withdrowItem.status isEqualToString:@"1"])
    {
        _indicatorLabel.textColor = RGB(251, 192, 87);
        _indicatorLabel.text = @"提现成功";
    }
    else
    {
        _indicatorLabel.text = @"提现失败";
    }
}


@end
