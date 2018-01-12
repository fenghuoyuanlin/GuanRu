//
//  LYCreditCardCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYCreditCardCell.h"
// Controllers

// Models
#import "LYCreditItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYCreditCardCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;
//内容
@property(nonatomic, strong) UILabel *messageLabel;

@end

@implementation LYCreditCardCell

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
    _titleLabel.font = PFR16Font;
    [self addSubview:_titleLabel];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = PFR13Font;
    _messageLabel.numberOfLines = 2;
    [self addSubview:_messageLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.top.equalTo(DCMargin);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.right.equalTo(-DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(5);
        make.left.equalTo(_titleLabel.left);
        make.right.equalTo(- 2*DCMargin);
    }];
    
}

#pragma mark - Setter Getter Methods

-(void)setCreditItem:(LYCreditItem *)creditItem
{
    _creditItem = creditItem;
    _imageNameView.image = [UIImage imageNamed:creditItem.imageName];
    _titleLabel.text = creditItem.title;
    _messageLabel.text = creditItem.message;
    
}
@end
