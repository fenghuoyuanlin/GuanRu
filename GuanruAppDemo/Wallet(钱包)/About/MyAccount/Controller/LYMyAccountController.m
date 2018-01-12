//
//  LYMyAccountController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyAccountController.h"
// Controllers

// Models
#import "LYAccountItem.h"
// Views
#import "LYAcountItemCell.h"
#import "LYAccountHeader.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories

// Others

@interface LYMyAccountController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LYAccountHeader *accountHeader;

@property(nonatomic, strong) NSMutableArray<LYAccountItem *> *accountArr;

@end

static NSString *const LYAcountItemCellID = @"LYAcountItemCell";

@implementation LYMyAccountController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 80, ScreenW, ScreenH - 64 - 80);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableHeaderView = self.accountHeader;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYAcountItemCell class] forCellReuseIdentifier:LYAcountItemCellID];
    }
    return _tableView;
}

-(LYAccountHeader *)accountHeader
{
    if (!_accountHeader)
    {
        _accountHeader = [[LYAccountHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    }
    return _accountHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self setUpRefreshHeader];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"我的商户";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    [self.view addSubview:self.accountHeader];
}

#pragma mark - 消息数据
-(void)setUpData
{
    _accountArr = [LYAccountItem mj_objectArrayWithFilename:@"Account.plist"];
}

#pragma mark - 上拉和下拉刷新
-(void)setUpRefreshHeader
{
//    __weak typeof(self) weakSelf = self;
//    //仿微博的下拉刷新
//    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableView reloadData];
//            // 结束刷新
//            [weakSelf.tableView.mj_header endRefreshing];
//        });
//    }];
//    //进入界面就开始刷新一下
//    [self.tableView.mj_header beginRefreshing];
//
//    // 上拉刷新
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableView reloadData];
//
//            // 结束刷新
//            [weakSelf.tableView.mj_footer endRefreshing];
//        });
//    }];
//    // 默认先隐藏footer
//    self.tableView.mj_footer.hidden = NO;
    
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYAcountItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYAcountItemCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accountItem = _accountArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
