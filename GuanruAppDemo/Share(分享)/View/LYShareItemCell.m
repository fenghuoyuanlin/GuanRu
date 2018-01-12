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
    _titleLabel.font = PFR18Font;
    [self addSubview:_titleLabel];
    
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
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(15);
        make.center.equalTo(self);
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
    
}

@end
