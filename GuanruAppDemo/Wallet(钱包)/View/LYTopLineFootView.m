//
//  LYTopLineFootView.m
//  ShoppingAppDemo
//
//  Created by 刘园 on 2017/7/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYTopLineFootView.h"
// Controllers

// Models

// Views
#import "LYNumberScrollView.h"
// Vendors

// Categories

// Others

@interface LYTopLineFootView ()<UIScrollViewDelegate,NoticeViewDelegate>
//跑马灯视图
@property(nonatomic, strong) LYNumberScrollView *numberScrollView;
//底部
@property(nonatomic, strong) UIView *bottomLineView;

@property(nonatomic, strong) UIView *topLine;

@end

@implementation LYTopLineFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return  self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = DCBGColor;
    _topLine.frame = CGRectMake(0, 5, ScreenW, 1);
    [self addSubview:_topLine];
    
    NSArray *titles = @[@"不及时到账?",
                        @"冻结不能提现?"
                        ];
    NSArray *btnts = @[@"[账单]",
                       @"[余额]"
                       ];
    //初始化
    _numberScrollView = [[LYNumberScrollView alloc]initWithFrame:CGRectMake(0, 0, self.dc_width, self.dc_height) andImage:@"text" andDataTArray:titles WithDataIArray:btnts];
    _numberScrollView.delegate = self;
    //设置定时器多久循环
    _numberScrollView.interval = 5;
    [self addSubview:_numberScrollView];
    //开始循环
    [_numberScrollView startTimer];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, ScreenW, 8);
}

#pragma mark - Setter Getter Methods

#pragma mark - 滚动条点击事件
- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index{
    NSLog(@"点击了第%zd头条滚动条",index);
    !_questionClickBlock  ? : _questionClickBlock();
}

@end
