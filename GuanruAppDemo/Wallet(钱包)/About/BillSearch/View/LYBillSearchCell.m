
//
//  LYBillSearchCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillSearchCell.h"
// Controllers

// Models
#import "LYBillItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYBillSearchCell ()

//图片
@property(nonatomic, strong) UIImageView *imgView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//时间
@property(nonatomic, strong) UILabel *timeLabel;
//店名
@property(nonatomic, strong) UILabel *storeLabel;
//金额上限
@property(nonatomic, strong) UILabel *moneyUpLabel;
//金额下限
@property(nonatomic, strong) UILabel *moneyBottomLabel;

@end

@implementation LYBillSearchCell

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
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"zfb"];
    [self addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"收款成功";
    [self addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    [self addSubview:_timeLabel];
    
    _storeLabel = [[UILabel alloc] init];
    [self addSubview:_storeLabel];
    
    _moneyUpLabel = [[UILabel alloc] init];
    [self addSubview:_moneyUpLabel];
    
    _moneyBottomLabel = [[UILabel alloc] init];
    _moneyBottomLabel.textColor = [UIColor redColor];
    [self addSubview:_moneyBottomLabel];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(20);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.left.equalTo(_imgView.right).offset(15);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(5);
        make.left.equalTo(_imgView.right).offset(15);
    }];
    
    [_storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.centerY);
        make.left.equalTo(_timeLabel.right).offset(15);
    }];
    
    [_moneyUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_moneyBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.top.equalTo(_moneyUpLabel.bottom).offset(5);
    }];
    
}

#pragma mark - Setter Getter Methods

-(void)setBillItem:(LYBillItem *)billItem
{
    _billItem = billItem;
    
    _timeLabel.text = [[DCSpeedy timeStampToStr:billItem.succTime] substringFromIndex:11];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"useralipayName"];
    _storeLabel.text = str;
    NSString *trmoney = [NSString stringWithFormat:@"￥%.2f", [billItem.amt doubleValue]];
    _moneyUpLabel.text = trmoney;
}


@end
