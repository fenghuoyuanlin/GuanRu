//
//  LYBankCardController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBankCardController.h"

@interface LYBankCardController ()
//添加按钮
@property(nonatomic, strong) UIButton *addBankBtn;

@end

@implementation LYBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡管理";
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _addBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBankBtn.frame = CGRectMake(DCMargin, DCMargin, ScreenW - 2*DCMargin, 45);
    _addBankBtn.backgroundColor = [UIColor whiteColor];
    [_addBankBtn setTitleColor:[UIColor blackColor] forState:0];
    [_addBankBtn setTitle:@"添加银行卡管理" forState:0];
    [self.view addSubview:_addBankBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
