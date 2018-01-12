//
//  LYLoginCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/4.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYLoginCell.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views

// Vendors

// Categories
#import "UITextField+GFPlaceholder.h"
// Others

@interface LYLoginCell ()
//横线
@property(nonatomic, strong) UIView *lineView;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;


@end

@implementation LYLoginCell

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
    self.backgroundColor = [UIColor clearColor];
    
//    _imageNameView = [[UIImageView alloc] init];
//    //    _imageNameView.backgroundColor = [UIColor redColor];
//    [self addSubview:_imageNameView];
    
    _textField = [[UITextField alloc] init];
    _textField.placeholderColor = [UIColor lightGrayColor];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textField];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = RGB(242, 243, 244);
    [self addSubview:_lineView];
    
}

#pragma mark - 布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_imageNameView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(DCMargin);
//        make.centerY.equalTo(self);
//        make.size.equalTo(CGSizeMake(20, 30));
//    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(-15);
    }];
    
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
    _textField.placeholder = registerItem.title;
}


@end
