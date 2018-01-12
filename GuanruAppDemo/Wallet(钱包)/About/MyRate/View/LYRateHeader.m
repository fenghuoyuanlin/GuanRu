//
//  LYRateHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRateHeader.h"
// Controllers

// Models

// Views
#import "SGEasyButton.h"
// Vendors

// Categories

// Others

@interface LYRateHeader ()

@end

#define AuxiliaryNum 100;

@implementation LYRateHeader

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
    self.backgroundColor = RGBA(66, 195, 234, 1.0);
    NSArray *titles = @[@"当面付", @"微信支付", @"QQ钱包", @"京东钱包"];
    //    NSArray *noImage = @[@"icon_Arrow2", @"icon_Arrow2", @"icon_Arrow2", @"icon_shaixuan"];
    CGFloat btnW = self.dc_width / titles.count;
    CGFloat btnH = self.dc_height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = i * btnW;
        [button SG_imagePositionStyle:SGImagePositionStyleTop spacing:20];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:noImage[i]] forState:UIControlStateNormal];
        button.tag = i + 100;
        button.titleLabel.font = PFR13Font;
        [self addSubview:button];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0)
        {
            [self buttonClick:button]; //默认选择第一个
        }
        
    }
}

#pragma mark - 布局

#pragma mark - Setter Getter Methods

#pragma mark - 按钮点击
-(void)buttonClick:(UIButton *)button
{
    //重复点击事件
//    if (self.selectBtn == button)
//    {
//        !_repeatClickBlock ? : _repeatClickBlock();
//    }
    
    if (button.tag == 3 + 100)//筛选
    {
        !_filtrateClickBlock ? : _filtrateClickBlock();
    }
    else
    {
        
        if (button.tag == 0 + 100)
        {
            !_recommendClickBlock ? : _recommendClickBlock();
        }
        else if (button.tag == 1 + 100)
        {
            !_priceClickBlock ? : _priceClickBlock();
        }
        else
        {
            !_salesClickBlock ? : _salesClickBlock();
        }
        
    }
    
}

@end
