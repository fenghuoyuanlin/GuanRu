//
//  LYDocumentsCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/7.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYDocumentsCell.h"
// Controllers

// Models
#import "LYDocumentItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYDocumentsCell ()


@end

@implementation LYDocumentsCell

#pragma mark - inital
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _imageNameView = [[UIImageView alloc] init];
    [self addSubview:_imageNameView];
    
}

#pragma mark - 布局

//对这个cell的真实有效部分进行设置
//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height -= DCMargin;
//    frame.origin.y += DCMargin;
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
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - Setter Getter Methods

-(void)setMessageItem:(LYDocumentItem *)messageItem
{
    _messageItem = messageItem;
    _imageNameView.image = [UIImage imageNamed:messageItem.imageName];
    
}

@end
