//
//  LYCustionHeadView.m
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/8/10.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYCustionHeadView.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface LYCustionHeadView ()
//记录上一次选中的Button
@property(nonatomic, weak) UIButton *selectBtn;
//记录上一次选中的Button底部的View
@property(nonatomic, strong) UIView *selectBottomRedView;

@end

#define AuxiliaryNum 100;

@implementation LYCustionHeadView

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
    NSArray *titles = @[@"推荐", @"价格", @"销量", @"筛选"];
//    NSArray *noImage = @[@"icon_Arrow2", @"icon_Arrow2", @"icon_Arrow2", @"icon_shaixuan"];
    CGFloat btnW = self.dc_width / titles.count;
    CGFloat btnH = self.dc_height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = i * btnW;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:noImage[i]] forState:UIControlStateNormal];
        button.tag = i + 100;
        [self addSubview:button];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
        if (i == 0)
        {
            [self buttonClick:button]; //默认选择第一个
        }

    }
    //设置本视图的下划线
    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.4]];
}

#pragma mark - 布局

#pragma mark - Setter Getter Methods

#pragma mark - 按钮点击
-(void)buttonClick:(UIButton *)button
{
    //重复点击事件
    if (self.selectBtn == button)
    {
        !_repeatClickBlock ? : _repeatClickBlock();
    }
    
    if (button.tag == 3 + 100)//筛选
    {
        !_filtrateClickBlock ? : _filtrateClickBlock();
    }
    else
    {
        _selectBottomRedView.hidden = YES;
        [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_Arrow2"] forState:UIControlStateNormal];
        UIView *bottomRedView = [[UIView alloc] init];
        [self addSubview:bottomRedView];
        bottomRedView.backgroundColor = [UIColor redColor];
        bottomRedView.dc_width = button.dc_width;
        bottomRedView.dc_height = 3;
        bottomRedView.dc_y = button.dc_height - bottomRedView.dc_height;
        bottomRedView.dc_x = button.dc_x;
        bottomRedView.hidden = NO;
        
        _selectBtn = button;
        _selectBottomRedView = bottomRedView;
        
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
