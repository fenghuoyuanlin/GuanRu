//
//  LYBillSearchController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillSearchController.h"
// Controllers
#import "LYBillDetailController.h"
// Models
#import "LYBillItem.h"
#import "LYBillDetailItem.h"
#import "LYDayItem.h"
#import "LYMerchantModel.h"
// Views
#import "LYBillSearchCell.h"
#import "LYBillHeader.h"
#import "LYProfitBottom.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories
#import "NSObject+Property.h"
// Others

@interface LYBillSearchController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYBillItem *> *billArr;

@property(nonatomic, strong) LYMerchantModel *merchantModel;

@property(nonatomic, strong) UIView *bottomHeader;

@property(nonatomic, strong) LYBillHeader *billHeader;

@property(nonatomic, assign) NSInteger page;

@property(nonatomic, strong) NSMutableArray<LYDayItem *> *mutableArrModel;

@property(nonatomic, strong) NSString *lastDate;

@end

static NSString *const LYBillSearchCellID = @"LYBillSearchCell";

@implementation LYBillSearchController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 130, ScreenW, ScreenH - 130 - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
//        _tableView.tableHeaderView = self.billHeader;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYBillSearchCell class] forCellReuseIdentifier:LYBillSearchCellID];
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

-(UIView *)bottomHeader
{
    if (!_bottomHeader)
    {
//        _bottomHeader = [[LYProfitBottom alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
//        __weak typeof(self) weakSelf = self;
//        _bottomHeader.accountBtnClickBlock = ^{
//            NSLog(@"点击了结算按钮");
//            [weakSelf rightLogin];
//        };
        
        _bottomHeader = [[UIView alloc] init];
        _bottomHeader.backgroundColor = RGBA(50, 112, 229, 1.0);
        _bottomHeader.frame = CGRectMake(0, 0, ScreenW, 40);

    }
    return _bottomHeader;
}

-(LYBillHeader *)billHeader
{
    if (!_billHeader)
    {
        _billHeader = [[LYBillHeader alloc] initWithFrame:CGRectMake(15, 20, ScreenW - 30, 110)];
    }
    return _billHeader;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor whiteColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR20Font;
    self.navigationController.navigationBar.barTintColor = RGBA(50, 112, 229, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR20Font;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
//    [self setUpMerchantData];
    [self setUpHeaderData];
    [self setUpData];
//    [self setUpNav];
    [self setUpRefreshHeader];
    
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"账单";
    _lastDate = @"0000-00-00";
    self.page = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    [self.view addSubview:self.bottomHeader];
    [self.view addSubview:self.billHeader];
}

#pragma mark - 设置导航栏
//-(void)setUpNav
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"清空消息" forState:0];
//    [button setTitleColor:[UIColor whiteColor] forState:0];
//    button.titleLabel.font = PFR14Font;
//    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//}

#pragma mark - 消息数据
-(void)setUpData
{
//    _billArr = [LYBillItem mj_objectArrayWithFilename:@"Bill.plist"];
    
    __weak typeof(self) weakSelf = self;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"pageIndex" : [NSString stringWithFormat:@"%ld", _page]
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetOrder Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"]) 
        {
            NSDictionary *dic = responseObject[@"Data"];
            NSArray *arr = dic[@"list"];
            if (arr.count == 0)
            {
                [DCSpeedy alertMes:@"主人还没有数据呦"];
            }
            else
            {
                _billArr = [LYBillItem mj_objectArrayWithKeyValuesArray:arr];
                for(LYBillItem *model in _billArr)
                {
                    NSString *date = [[DCSpeedy timeStampToStr:model.succTime] substringToIndex:10];
                    if (![date isEqualToString:_lastDate])
                    {
                        LYDayItem *item = [[LYDayItem alloc] init];
                        item.dayStr = date;
                        NSLog(@"%@", item.dayStr);
                        item.listArr = [NSMutableArray arrayWithCapacity:1];
                        [item.listArr addObject:model];
                        NSLog(@"%@", item.listArr);
                        [weakSelf.mutableArrModel addObject:item];
                        NSLog(@"%@", weakSelf.mutableArrModel);
                        NSLog(@"%@", item.listArr);
                        _lastDate = date;
                    }
                    else
                    {
                        LYDayItem *item = [weakSelf.mutableArrModel lastObject];
                        [item.listArr addObject:model];
                        NSLog(@"%@", item.listArr);
                    }
                    
                }
                
                [weakSelf.tableView reloadData];
                
                if (weakSelf.billArr.count == 10)
                {
                    [weakSelf.tableView.mj_footer endRefreshing];//有数据可以加载
                }
                else
                {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//没有数据可以加载
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma mark - 获取数据
//-(void)setUpMerchantData
//{
//    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
//    NSDictionary *dic = @{
//                          @"agentid": userid
//                          };
//    __weak typeof(self) weakSelf = self;
//
//    [AFOwnerHTTPSessionManager getAddToken:GetAccountBalance Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [hud hideAnimated:YES];
//        });
//        NSLog(@"%@", responseObject);
//        NSString *code = responseObject[@"code"];
//        if ([code isEqualToString:@"0000"])
//        {
//            NSDictionary *dic = responseObject[@"Data"];
//            weakSelf.merchantModel = [LYMerchantModel mj_objectWithKeyValues:dic];
//            NSLog(@"%@", _merchantModel.amt);
//            weakSelf.bottomHeader.numLabel.text = [NSString stringWithFormat:@"%.2f", [_merchantModel.amt doubleValue]];
////            weakSelf.bottomMoney.text = [NSString stringWithFormat:@"%.2f", [_merchantModel.deposit doubleValue]];
//        }
//        else
//        {
////            [hud hideAnimated:YES];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
////        [hud hideAnimated:YES];
//    }];
//}


-(void)setUpHeaderData
{
    __weak typeof(self) weakSelf = self;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetOrderData Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            LYBillDetailItem *detailItem = [LYBillDetailItem mj_objectWithKeyValues:dic];
            weakSelf.billHeader.moneyUpLabel.text = [NSString stringWithFormat:@"%@笔", detailItem.tradeNum];
            weakSelf.billHeader.moneyBottomLabel.text = [NSString stringWithFormat:@"%.2f", [detailItem.tradeAmount doubleValue]];
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
            _lastDate = @"0000-00-00";
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
        });
    }];
    // 默认先隐藏footer
    self.tableView.mj_footer.hidden = NO;
    
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArrModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArrModel[section].listArr.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.mutableArrModel[section].dayStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBillSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:LYBillSearchCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.billItem = self.mutableArrModel[indexPath.section].listArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBillDetailController *detailVC = [[LYBillDetailController alloc] init];
    detailVC.billDetailItem = self.mutableArrModel[indexPath.section].listArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


//#pragma mark - 温馨提示
//-(void)rightLogin
//{
//    __weak typeof(self) weakSelf = self;
//    NSString *str = [NSString stringWithFormat:@"确定要结算账户上的余额\n%@元吗?", [NSString stringWithFormat:@"%.2f", [_merchantModel.amt doubleValue]]];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        NSLog(@"点击取消");
//
//    }]];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSLog(@"点击确认");
//        [weakSelf setUpCloseAccount];
//
//    }]];
//
//    [self presentViewController:alertController animated:YES completion:nil];
//}

//#pragma mark - 我要结算
//-(void)setUpCloseAccount
//{
//    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = @{
//                          @"agentid": userid,
//                          @"money" : self.bottomHeader.numLabel.text
//                          };
//
//    [AFOwnerHTTPSessionManager getAddToken:Withdrawal Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        NSString *code = responseObject[@"code"];
//        if ([code isEqualToString:@"0000"])
//        {
//            weakSelf.bottomHeader.numLabel.text = @"0.00";
//            [DCSpeedy alertMes:@"提现成功"];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
