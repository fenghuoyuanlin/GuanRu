//
//  LYAgentsCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/14.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYAgentsCell.h"
// Controllers

// Models
#import "LYAgentItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYAgentsCell ()
//代理商名称
@property(nonatomic, strong) UILabel *agentLabel;
//时间
@property(nonatomic, strong) UIButton *editBtn;
//费率
@property(nonatomic, strong) UILabel *rateLabel;

@end

@implementation LYAgentsCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    _agentLabel = [[UILabel alloc] init];
    _agentLabel.font = PFR14Font;
    _agentLabel.textColor = RGB(202, 69, 83);
    [self addSubview:_agentLabel];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitle:@"编辑" forState:0];
    [_editBtn setTitleColor:RGB(0, 91, 251) forState:0];
    _editBtn.titleLabel.font = PFR16Font;
    [self addSubview:_editBtn];
    
    [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _rateLabel = [[UILabel alloc] init];
    _rateLabel.font = PFR14Font;
    _rateLabel.textColor = RGB(239, 99, 117);
    [self addSubview:_rateLabel];
    
}

#pragma mark - 布局

//对这个cell的真实有效部分进行设置
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= DCMargin;
    frame.origin.y += DCMargin;
    
    frame.origin.x += DCMargin;
    frame.size.width -=  2 * DCMargin;
    
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_agentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(DCMargin);
    }];
    
    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.top.equalTo(_agentLabel.bottom).offset(DCMargin);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.centerY.equalTo(_agentLabel.centerY);
    }];
    
}

#pragma mark - Setter Getter Mentods
-(void)setAgentItem:(LYAgentItem *)agentItem
{
    _agentItem = agentItem;
    
    _agentLabel.text = [NSString stringWithFormat:@"代理商名称:%@", agentItem.merchant_name];
    NSString *str = [NSString stringWithFormat:@"%.2f", [agentItem.rate_value doubleValue] * 100];
    NSString *sttt = [DCSpeedy changeFloat:str];
    _rateLabel.text = [NSString stringWithFormat:@"%@%@%@", @"小额费率:", sttt, @"%"];
}

#pragma mark - 点击事件
-(void)editBtnClick
{
    !_editBtnClickBlock  ? : _editBtnClickBlock();
}

@end
