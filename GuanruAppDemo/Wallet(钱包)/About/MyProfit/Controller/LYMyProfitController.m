//
//  LYMyProfitController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyProfitController.h"
// Controllers

// Models

// Views
#import "LYProfitHeader.h"
#import "LYProfitBottom.h"
// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface LYMyProfitController ()

@property(nonatomic, strong) LYProfitHeader *headerView;

@property(nonatomic, strong) LYProfitBottom *bottomView;

@end

@implementation LYMyProfitController

#pragma mark - lazyLoad

-(LYProfitHeader *)headerView
{
    if (!_headerView)
    {
        _headerView = [[LYProfitHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    }
    return _headerView;
}

-(LYProfitBottom *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[LYProfitBottom alloc] initWithFrame:CGRectMake(20, 130, ScreenW - 40, ScreenH - 130 - 64)];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCBGColor;
    self.title = @"分润";
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bottomView];
    [self setUpNav];
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"收益明细" forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.titleLabel.font = PFR14Font;
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


#pragma mark - 点击事件
-(void)rightBarClick
{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
