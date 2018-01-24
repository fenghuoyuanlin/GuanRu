//
//  LYServiceItemCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/23.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYServiceItemCell.h"
// Controllers

// Models
#import "LYServiceItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYServiceItemCell ()
//图片
@property(nonatomic, strong) UIImageView *imageNameView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//内容
@property(nonatomic, strong) UILabel *infoLabel;
//箭头图片
@property(nonatomic, strong) UIImageView *jinImgView;
//底部分割线
@property(nonatomic, strong) UIView *cellLine;

@end
@implementation LYServiceItemCell

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
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR18Font;
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.textColor = [UIColor lightGrayColor];
    _infoLabel.font = PFR15Font;
    [self addSubview:_infoLabel];
    
    _jinImgView = [[UIImageView alloc] init];
    _jinImgView.image = [UIImage imageNamed:@"箭2"];
    [self addSubview:_jinImgView];
    
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
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.centerY.equalTo(self.centerY);
    }];
    
    [_jinImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-DCMargin);
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(15, 22));
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_jinImgView.left).offset(-5);
        make.centerY.equalTo(self.centerY);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
}

#pragma mark - Setter Getter Methods
-(void)setServiceItem:(LYServiceItem *)serviceItem
{
    _serviceItem = serviceItem;
    _imageNameView.image = [UIImage imageNamed:serviceItem.iconImage];
    _infoLabel.text = serviceItem.info;
    _titleLabel.text = serviceItem.gridTitle;
}

@end
