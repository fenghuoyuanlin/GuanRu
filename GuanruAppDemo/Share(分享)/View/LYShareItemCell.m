//
//  LYShareItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYShareItemCell.h"
// Controllers

// Models
#import "LYShareItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYShareItemCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//内容
@property(nonatomic, strong) UILabel *infoLabel;
//详情
@property(nonatomic, strong) UIImageView *indicatorImgView;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;

@end

@implementation LYShareItemCell

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
    if (iphone5)
    {
        _titleLabel.font = PFR16Font;
    }
    else
    {
        _titleLabel.font = PFR18Font;
    }
    
    _titleLabel.textColor = RGB(5, 123, 250);
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    if (iphone5)
    {
        _infoLabel.font = PFR12Font;
    }
    else
    {
        _infoLabel.font = PFR14Font;
    }
    _infoLabel.numberOfLines = 0;
    _infoLabel.textColor = RGB(50, 50, 50);
    [self addSubview:_infoLabel];
    
    _indicatorImgView = [[UIImageView alloc] init];
    _indicatorImgView.image = [UIImage imageNamed:@"箭2"];
    [self addSubview:_indicatorImgView];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
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
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(70, 70));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(15);
        make.top.equalTo(_imageNameView.top).offset(0);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(5);
        make.left.equalTo(_titleLabel.left);
        make.right.equalTo(_indicatorImgView.left).offset(-20);
    }];
    
    [_indicatorImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-DCMargin);
        make.size.equalTo(CGSizeMake(15, 22));
    }];
    

}

#pragma mark - Setter Getter Methods

-(void)setMessageItem:(LYShareItem *)messageItem
{
    _messageItem = messageItem;
    _imageNameView.image = [UIImage imageNamed:messageItem.imageName];
    _titleLabel.text = messageItem.title;
    _infoLabel.text = messageItem.info;
    
}

@end
