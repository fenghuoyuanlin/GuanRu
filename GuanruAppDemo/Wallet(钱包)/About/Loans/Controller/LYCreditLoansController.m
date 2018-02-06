//
//  LYCreditLoansController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYCreditLoansController.h"
// Controllers
#import "LYCreditCardController.h"
// Models

// Views

// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface LYCreditLoansController ()

//底部view
@property(nonatomic, strong) UIView *bottomView;
//底部Btn
@property(nonatomic, strong) UIButton *bottomBtn;

@end

@implementation LYCreditLoansController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpBottomView];

}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"生成链接";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 创建底部按钮
-(void)setUpBottomView
{
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-KSafeBarHeight);
        make.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.layer.cornerRadius = 15.0;
    _bottomBtn.layer.masksToBounds = YES;
    [_bottomBtn setImage:[UIImage imageNamed:@"添加"] forState:0];
    [_bottomBtn setTitle:@"新增收款码" forState:0];
    [_bottomBtn setBackgroundColor:RGB(45, 123, 234)];
    [self.view addSubview:_bottomBtn];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(_bottomView.top).offset(7.5);
        make.bottom.equalTo(_bottomView.bottom).offset(-7.5);
        make.right.equalTo(-15);
    }];
}

#pragma mark - 点击事件
-(void)bottomBtnClick
{
    NSLog(@"点击了新增按钮");
    [self.navigationController pushViewController:[[LYCreditCardController alloc] init] animated:YES];
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
