//
//  LYChangePassCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYChangePassCell.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views

// Vendors

// Categories
#import "UITextField+GFPlaceholder.h"
// Others

@interface LYChangePassCell ()

//标题
@property(nonatomic, strong) UILabel *titleLabel;


@end


@implementation LYChangePassCell

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
    
    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.placeholderColor = [UIColor lightGrayColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textField];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(70, 40));
    }];
    
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.right).offset(12);
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(-15);
    }];
    
    
}

#pragma mark - Setter Getter Methods

-(void)setRegisterItem:(LYRegisterItem *)registerItem
{
    _registerItem = registerItem;
    _titleLabel.text = registerItem.imageName;
    _textField.placeholder = registerItem.title;
}

@end
