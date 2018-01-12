//
//  LYFillDataCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/21.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYFillDataCell.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views

// Vendors

// Categories
#import "UITextField+GFPlaceholder.h"
// Others

@interface LYFillDataCell ()
//横线
@property(nonatomic, strong) UIView *lineView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;


@end

@implementation LYFillDataCell

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
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor lightGrayColor];
//    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_contentLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = DCBGColor;
    [self addSubview:_lineView];
    
    _flag = NO;
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(80, 35));
    }];
    
    if (_flag)
    {
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.right).offset(DCMargin);
            make.centerY.equalTo(self.centerY);
            make.height.equalTo(25);
            make.right.equalTo(-15);
        }];
    }
    else
    {
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.right).offset(15);
            make.centerY.equalTo(self.centerY);
        }];
    }
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
    }];
    
    
    
}

#pragma mark - Setter Getter Methods

-(void)setRegisterItem:(LYRegisterItem *)registerItem
{
    _registerItem = registerItem;
    
    if (_flag)
    {
        _textField.placeholder = registerItem.imageName;
    }
    else
    {
        _contentLabel.text = registerItem.imageName;
    }
    _titleLabel.text = registerItem.title;
}



@end
