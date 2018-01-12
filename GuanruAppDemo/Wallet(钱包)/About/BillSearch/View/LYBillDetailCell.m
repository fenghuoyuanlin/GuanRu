//
//  LYBillDetailCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillDetailCell.h"
// Controllers

// Models
#import "LYBillDetail.h"
// Views

// Vendors

// Categories

// Others

@interface LYBillDetailCell ()

//标题
@property(nonatomic, strong) UILabel *titleLabel;
//时间


@end

@implementation LYBillDetailCell

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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = RGB(97, 98, 99);
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.textColor = RGB(97, 98, 99);
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
        make.right.equalTo(-DCMargin);
        make.centerY.equalTo(self.centerY);
    }];
}

#pragma mark - Setter Getter Methods

-(void)setBillDetailItem:(LYBillDetail *)billDetailItem
{
    _billDetailItem = billDetailItem;
    _titleLabel.text = billDetailItem.title;
}


@end
