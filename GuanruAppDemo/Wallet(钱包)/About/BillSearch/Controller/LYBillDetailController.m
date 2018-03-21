//
//  LYBillDetailController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/28.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYBillDetailController.h"
// Controllers

// Models
#import "LYBillDetail.h"
// Views
#import "LYBillDetailCell.h"
#import "LYBillDetailHeader.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories

// Others

@interface LYBillDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LYBillDetailHeader *headerView;

@property(nonatomic, strong) NSMutableArray<LYBillDetail *> *billDetailArr;

@property(nonatomic, strong) NSArray *userArr;

@end

static NSString *const LYBillDetailCellID = @"LYBillDetailCell";

@implementation LYBillDetailController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 65, ScreenW, ScreenH - 64 - 60);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYBillDetailCell class] forCellReuseIdentifier:LYBillDetailCellID];
    }
    return _tableView;
}

-(LYBillDetailHeader *)headerView
{
    if (!_headerView)
    {
        _headerView = [[LYBillDetailHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
        NSString *str = [NSString stringWithFormat:@"+%@", [NSString stringWithFormat:@"%.2f", [_billDetailItem.amt doubleValue]]];
        _headerView.moneyUpLabel.text = str;
        
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self setUpBase];
   
    //    [self setUpNav];
//    [self setUpRefreshHeader];
    [self setUpTopView];
    
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"账单详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
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

#pragma mark - 头部视图
-(void)setUpTopView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"收款成功"] forState:0];
    [btn setTitle:@"收款成功" forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DCMargin);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(130, 30));
    }];
}

#pragma mark - 消息数据
-(void)setUpData
{
    _billDetailArr = [LYBillDetail mj_objectArrayWithFilename:@"BillDetail.plist"];
    NSString *date = [DCSpeedy timeStampToStr:_billDetailItem.succTime];
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"useralipayName"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    NSString *aliaccount = [[NSUserDefaults standardUserDefaults] objectForKey:@"useralipayaccount"];
    //对手机号中间部位进行加*处理
    NSString *phoneStr = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    NSString *userAmt = [NSString stringWithFormat:@"%.2f", [_billDetailItem.userAmt doubleValue]];
    NSString *bankId = _billDetailItem.bankorderid;
    
    if ([_billDetailItem.productid isEqualToString:@"3"])
    {
        _userArr = @[date, @"支付宝", phoneStr, user, aliaccount, bankId, userAmt, @"信用卡支付"];
    }
    else
    {
        _userArr = @[date, @"支付宝", phoneStr, user, aliaccount, bankId, userAmt, @"花呗支付"];
    }
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _billDetailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:LYBillDetailCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.billDetailItem = _billDetailArr[indexPath.row];
    cell.infoLabel.text = _userArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
