//
//  LYMessageNoteCell.m
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/8/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMessageNoteCell.h"
// Controllers

// Models
#import "LYMessageItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYMessageNoteCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;
//消息
@property(nonatomic, strong) UILabel *messageLabel;
//底部分割线
@property(nonatomic, strong) UIView *cellLine;

@end

@implementation LYMessageNoteCell

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
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = PFR13Font;
    [self addSubview:_messageLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _cellLine = [[UIView alloc] init];
    _cellLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:_cellLine];
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.top.equalTo(DCMargin);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(64);
        make.right.equalTo(-DCMargin);
        make.top.equalTo(DCMargin);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(5);
        make.left.equalTo(_titleLabel.left);
        make.right.equalTo(-DCMargin);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
}

#pragma mark - Setter Getter Methods

-(void)setMessageItem:(LYMessageItem *)messageItem
{
    _messageItem = messageItem;
    _imageNameView.image = [UIImage imageNamed:messageItem.imageName];
    _titleLabel.text = messageItem.title;
    _messageLabel.text = messageItem.message;
    
}

@end
