//
//  LYGatherCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYGatherCell.h"
// Controllers

// Models
#import "LYGatherItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYGatherCell ()
//收款
@property(nonatomic, strong) UILabel *gatherLabel;
//日期
@property(nonatomic, strong) UILabel *dateLabel;
//余额
@property(nonatomic, strong) UILabel *banlanceLabel;
//金额
@property(nonatomic, strong) UILabel *moneyLabel;

@end

@implementation LYGatherCell

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
    _gatherLabel = [[UILabel alloc] init];
    _gatherLabel.font = PFR18Font;
    _gatherLabel.text = @"收款";
    [self addSubview:_gatherLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = PFR14Font;
    _dateLabel.textColor = RGB(159, 160, 161);
    [self addSubview:_dateLabel];
    
    _banlanceLabel = [[UILabel alloc] init];
    _banlanceLabel.font = PFR14Font;
    _banlanceLabel.textColor = RGB(119, 119, 120);
    [self addSubview:_banlanceLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = PFR18Font;
    [self addSubview:_moneyLabel];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_banlanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.top.equalTo(_gatherLabel.bottom).offset(DCMargin);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.right.equalTo(-DCMargin);
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.bottom).offset(DCMargin);
        make.right.equalTo(-DCMargin);
    }];
    
}

#pragma mark - Setter Getter Methods

-(void)setGatherItem:(LYGatherItem *)gatherItem
{
    _gatherItem = gatherItem;

    _dateLabel.text = [DCSpeedy timeStampToStr:gatherItem.createTime];
    NSString *str1 = [NSString stringWithFormat:@"+%.2f",[gatherItem.amt doubleValue]];
    _banlanceLabel.text = str1;
    NSString *str = [NSString stringWithFormat:@"+%.2f",[gatherItem.tradeAmt doubleValue]];
    _moneyLabel.text = str;
    
}

@end
