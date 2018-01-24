//
//  LYMesDetailController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/12.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYMesDetailController.h"

@interface LYMesDetailController ()
//详情信息
@property(nonatomic, strong) UILabel *detailLabel;

@end

@implementation LYMesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"公告详情";
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.text = _detailStr;
    _detailLabel.numberOfLines = 0;
    [self.view addSubview:_detailLabel];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.left.equalTo(DCMargin);
        make.right.equalTo(-DCMargin);
    }];
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
