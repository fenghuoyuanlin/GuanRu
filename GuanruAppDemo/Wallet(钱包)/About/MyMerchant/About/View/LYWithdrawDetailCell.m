//
//  LYWithdrawDetailCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/2/1.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYWithdrawDetailCell.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYWithdrawDetailCell ()


@end

@implementation LYWithdrawDetailCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = RGB(126, 126, 126);
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    [self addSubview:_infoLabel];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(DCMargin);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(-DCMargin);
    }];
    
    
}

#pragma mark - Setter Getter Methods


@end
