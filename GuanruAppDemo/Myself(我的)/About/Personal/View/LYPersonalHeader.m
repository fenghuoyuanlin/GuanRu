//
//  LYPersonalHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYPersonalHeader.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYPersonalHeader ()
//内容
@property(nonatomic, strong) UILabel *infoLabel;

@end
@implementation LYPersonalHeader

#pragma mark - initial
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
    self.backgroundColor = RGBA(255, 249, 243, 1.0);
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = PFR12Font;
    _infoLabel.textColor = RGB(240, 127, 73);
    _infoLabel.numberOfLines = 0;
    _infoLabel.text = @"您所有的联系方式将不会展示给您直接推广的下级看，如需展示，请在隐私开关里进行设置";
    [self addSubview:_infoLabel];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(DCMargin);
        make.bottom.right.equalTo(-DCMargin);
    }];
    
}

@end
