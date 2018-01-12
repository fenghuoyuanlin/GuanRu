//
//  LYUpdateTwoCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYUpdateTwoCell.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYUpdateTwoCell ()

@end

@implementation LYUpdateTwoCell

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
    
    _indicatorView = [[UIView alloc] init];
    [self addSubview:_indicatorView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR14Font;
    [self addSubview:_titleLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = PFR14Font;
    [self addSubview:_infoLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR14Font;
    [self addSubview:_contentLabel];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(0);
        make.width.equalTo(5);
    }];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.top.equalTo(_titleLabel.bottom).offset(5);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.top.equalTo(_infoLabel.bottom).offset(5);
    }];

}


@end
