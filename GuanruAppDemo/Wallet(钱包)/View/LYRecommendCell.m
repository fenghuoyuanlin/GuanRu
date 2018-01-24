//
//  LYRecommendCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRecommendCell.h"
// Controllers

// Models
#import "LYCardItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYRecommendCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//详情
@property(nonatomic, strong) UILabel *infoLabel;
//图片
@property(nonatomic, strong) UIImageView *imgView;

@end


@implementation LYRecommendCell

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
    self.backgroundColor = RGB(241, 243, 255);
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    if (iphone5)
    {
        _titleLabel.font = PFR13Font;
    }
    else
    {
        _titleLabel.font = PFR15Font;
    }
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    if (iphone5)
    {
        _infoLabel.font = PFR10Font;
    }
    else
    {
        _infoLabel.font = PFR13Font;
    }
    _infoLabel.textColor = RGB(131, 133, 135); 
    [self addSubview:_infoLabel];
    
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];

}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(-5);
        if (iphone5)
        {
            make.size.equalTo(CGSizeMake(40, 40));
        }
        else
        {
            make.size.equalTo(CGSizeMake(50, 50));
        }
    }];
    
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iphone5)
        {
            make.left.equalTo(DCMargin);;
        }
        else
        {
            make.left.equalTo(2 * DCMargin);;
        }
        make.top.equalTo(_imgView.top).offset(-5);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(DCMargin);
        if (iphone5)
        {
            make.left.equalTo(DCMargin);;
        }
        else
        {
            make.left.equalTo(2 * DCMargin);;
        }
    }];
    
}

#pragma mark - Setter Getter Methods
-(void)setCardItem:(LYCardItem *)cardItem
{
    _cardItem = cardItem;
    _titleLabel.text = cardItem.gridTitle;
    _infoLabel.text = cardItem.info;
    _imgView.image = [UIImage imageNamed:cardItem.iconImage];
}

@end
