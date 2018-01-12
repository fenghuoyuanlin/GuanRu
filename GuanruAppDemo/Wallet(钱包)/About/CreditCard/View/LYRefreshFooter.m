//
//  LYRefreshFooter.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRefreshFooter.h"

@implementation LYRefreshFooter

-(void)prepare
{
    [super prepare];
    
    //上拉刷新，友情提醒
    [self setTitle:@"已帮您加载完全部数据" forState:MJRefreshStateNoMoreData];
}


@end
