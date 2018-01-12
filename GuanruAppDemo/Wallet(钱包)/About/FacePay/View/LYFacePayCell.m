//
//  LYFacePayCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYFacePayCell.h"
// Controllers

// Models

// Views

// Vendors

// Categories
#import "UITextField+GFPlaceholder.h"
// Others

@interface LYFacePayCell ()

//内容
@property(nonatomic, strong) UILabel *infoLabel;
//图片
@property(nonatomic, strong) UIImageView *imgView;

@end

@implementation LYFacePayCell

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
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"口碑"];
//    [self addSubview:_imgView];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = @"口碑";
//    [self addSubview:_infoLabel];
    
    _titleLabel = [[UILabel alloc] init];
    
//    [self addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.placeholderColor = [UIColor lightGrayColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self addSubview:_textField];
    _flag = NO;
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_flag)
    {
        [self addSubview:_imgView];
        [self addSubview:_infoLabel];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(DCMargin);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(25, 25));
        }];
        
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.right).offset(DCMargin);
            make.centerY.equalTo(self.centerY);
        }];
    }
    else
    {
        [self addSubview:_titleLabel];
        [self addSubview:_textField];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(DCMargin);
            make.centerY.equalTo(self);
            make.size.equalTo(CGSizeMake(45, 35));
        }];
        
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.right).offset(10);
            make.centerY.equalTo(self.centerY);
            make.right.equalTo(-15);
        }];
    }
    
    
    
}


@end
