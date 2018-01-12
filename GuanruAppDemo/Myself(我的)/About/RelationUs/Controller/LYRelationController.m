//
//  LYRelationController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRelationController.h"

@interface LYRelationController ()

@end

@implementation LYRelationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"关于我们";
    [self setUpNav];
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"分享" forState:0];
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
