//
//  LYAcountItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYAcountItemCell.h"
// Controllers

// Models
#import "LYAccountItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYAcountItemCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;
//关联
@property(nonatomic, strong) UILabel *infoLabel;
//内容
@property(nonatomic, strong) UILabel *contentLabel;

@end

@implementation LYAcountItemCell

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
    _titleLabel.font = PFR14Font;
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = PFR13Font;
    [self addSubview:_infoLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR11Font;
    [self addSubview:_contentLabel];
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(74);
        make.top.equalTo(DCMargin);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(74);
        make.top.equalTo(_titleLabel.bottom).offset(5);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(- 4*DCMargin);
    }];
}

#pragma mark - Setter Getter Methods

-(void)setAccountItem:(LYAccountItem *)accountItem
{
    _accountItem = accountItem;
    _imageNameView.image = [UIImage imageNamed:@"icon"];
    _titleLabel.text = accountItem.title;
    _infoLabel.text = accountItem.info;
    _contentLabel.text = accountItem.content;
}

@end
