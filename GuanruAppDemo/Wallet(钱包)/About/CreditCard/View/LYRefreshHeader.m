//
//  LYRefreshHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRefreshHeader.h"

@implementation LYRefreshHeader

/**
 初始化
 */
-(void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor orangeColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    
    [self setTitle:@"下拉精彩不断" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"精彩推送中" forState:MJRefreshStateRefreshing];
    
    
}
@end
