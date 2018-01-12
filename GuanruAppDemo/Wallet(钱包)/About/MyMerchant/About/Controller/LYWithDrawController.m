//
//  LYWithDrawController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYWithDrawController.h"
// Controllers

// Models
#import "LYWithdrowItem.h"
#import "LYWithDetailItem.h"
// Views
#import "LYWithdrawCell.h"
#import "LYWithdrowHeader.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface LYWithDrawController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYWithdrowItem *> *withdrowArr;
//头部视图
@property(nonatomic, strong) LYWithdrowHeader *headerView;

@property(nonatomic, assign) NSInteger page;

@property(nonatomic, strong) NSMutableArray *mutableArrModel;

@end

static NSString *const LYWithdrawCellID = @"LYWithdrawCell";

@implementation LYWithDrawController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, _height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYWithdrawCell class] forCellReuseIdentifier:LYWithdrawCellID];
    }
    return _tableView;
}

-(NSMutableArray *)mutableArrModel
{
    if (!_mutableArrModel)
    {
        _mutableArrModel = [NSMutableArray arrayWithCapacity:1];
    }
    return _mutableArrModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self setUpNav];
    [self setUpRefreshHeader];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    self.page = 1;
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
    _withdrowArr = [LYWithdrowItem mj_objectArrayWithFilename:@"Withdrow.plist"];
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"balanceType" : @"1",
                          @"pageIndex" : [NSString stringWithFormat:@"%ld", _page]
                          };
    [AFOwnerHTTPSessionManager getAddToken:balance_change Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            NSArray *arr = dic[@"list"];
            _withdrowArr = [LYWithdrowItem mj_objectArrayWithKeyValuesArray:arr];
            for(LYWithdrowItem *model in _withdrowArr)
            {
                [weakSelf.mutableArrModel addObject:model];
                
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.withdrowArr.count == 10)
            {
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            else
            {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.page = 1;
            self.mutableArrModel = nil;
            [self setUpData];
            [weakSelf.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    //进入界面就开始刷新一下
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.page++;
            [weakSelf setUpData];
            [weakSelf.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    self.tableView.mj_footer.hidden = NO;
    
    
}

#pragma mark - <UITableViewDataSource>

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _withdrowArr.count;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArrModel.count;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _withdrowArr[section].headTitle;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    _headerView = [[LYWithdrowHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 25)];
//    _headerView.titleLabel.text = _withdrowArr[section].headTitle;
//    _headerView.backgroundColor = DCBGColor;
//    return _headerView;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 25;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWithdrawCell *cell = [tableView dequeueReusableCellWithIdentifier:LYWithdrawCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.withdrowItem = self.mutableArrModel[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
