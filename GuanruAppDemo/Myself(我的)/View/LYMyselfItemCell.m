//
//  LYMyselfItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyselfItemCell.h"
// Controllers

// Models
#import "LYMyselfItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYMyselfItemCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;

//底部分割线
@property(nonatomic, strong) UIView *cellLine;
//箭头图片
@property(nonatomic, strong) UIImageView *imgView;

@end


@implementation LYMyselfItemCell

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
    _messageLabel.font = PFR16Font;
    [self addSubview:_messageLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _cellLine = [[UIView alloc] init];
    _cellLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:_cellLine];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"箭2"];
    [self addSubview:_imgView];
}

#pragma mark - 布局
//对这个cell的真实有效部分进行设置
//-(void)setFrame:(CGRect)frame
//{
//    
//    frame.origin.x += DCMargin;
//    frame.size.width -=  2 * DCMargin;
//    
//    [super setFrame:frame];
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(35, 35));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(74);
        make.centerY.equalTo(self);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(- 15);
        make.centerY.equalTo(self);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(-DCMargin);
        make.size.equalTo(CGSizeMake(15, 20));
    }];
}

#pragma mark - Setter Getter Methods

-(void)setMyselfItem:(LYMyselfItem *)myselfItem
{
    _myselfItem = myselfItem;
    _imageNameView.image = [UIImage imageNamed:myselfItem.imageName];
    _titleLabel.text = myselfItem.title;
    
}


@end
