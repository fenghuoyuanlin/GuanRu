//
//  LYMessageViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMessageViewController.h"
// Controllers
#import "LYLoginViewController.h"
#import "LYMesDetailController.h"
// Models
#import "LYMessageItem.h"
#import "LYMessageModel.h"
// Views
#import "LYMessageNoteCell.h"
#import "LYMessageModelCell.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface LYMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYMessageModel *> *messageArr;

@end

static NSString *const LYMessageModelCellID = @"LYMessageModelCell";

@implementation LYMessageViewController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64 - KSafeBarHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYMessageModelCell class] forCellReuseIdentifier:LYMessageModelCellID];
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    if (str)
    {
        [self setUpRefreshHeader];
    }
    else
    {
        [DCSpeedy alertMes:@"主人您还没有登录哦，暂时不能查看"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
//    [self setUpData];
//    [self setUpNav];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"清空消息" forState:0];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.titleLabel.font = PFR14Font;
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 消息数据
-(void)setUpData
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:userid forKey:@"agentid"];
    NSLog(@"%@", dic);
    __weak typeof(self) weakSelf = self;
    [AFOwnerHTTPSessionManager getAddToken:GetAgentMessage Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSArray *arr = [responseObject objectForKey:@"Data"];
            if (arr.count == 0)
            {
                [DCSpeedy alertMes:@"暂无消息"];
            }
            else
            {
                _messageArr = [LYMessageModel mj_objectArrayWithKeyValuesArray:arr];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

#pragma mark - 上拉和下拉刷新
-(void)setUpRefreshHeader
{
    __weak typeof(self) weakSelf = self;
    //仿微博的下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf setUpData];
            [weakSelf.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    //进入界面就开始刷新一下
    [self.tableView.mj_header beginRefreshing];
    
//    // 上拉刷新
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    return _messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYMessageModelCell *cell = [tableView dequeueReusableCellWithIdentifier:LYMessageModelCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageItem = _messageArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYMesDetailController *detailVC = [[LYMesDetailController alloc] init];
    detailVC.detailStr = _messageArr[indexPath.row].Content;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - 点击事件
-(void)rightBarClick
{
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要清空里面的所有信息？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        _messageArr = nil;
        [weakSelf.tableView reloadData];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
