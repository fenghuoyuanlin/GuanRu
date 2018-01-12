//
//  LYUpdateOneCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYUpdateOneCell.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYUpdateOneCell ()

@end


@implementation LYUpdateOneCell

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
    _titleLabel.font = PFR14Font;
    [self addSubview:_titleLabel];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(22, 22));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageNameView.right).offset(DCMargin);
        make.right.equalTo(-DCMargin);
        make.centerY.equalTo(self);
    }];
    
}


@end
