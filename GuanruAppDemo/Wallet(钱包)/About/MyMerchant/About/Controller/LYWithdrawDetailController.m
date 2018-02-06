//
//  LYWithdrawDetailController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/2/1.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYWithdrawDetailController.h"
// Controllers
#import "LYAliccountController.h"
#import "LYWalletServiceController.h"
// Models

// Views
#import "LYWithdrawDetailCell.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories

// Others

@interface LYWithdrawDetailController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;
//标题数组
@property(nonatomic, strong) NSArray *titleArr;
//详情数组
@property(nonatomic, strong) NSArray *infoArr;

@end

static NSString *const LYWithdrawDetailCellID = @"LYWithdrawDetailCell";

@implementation LYWithdrawDetailController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 120, ScreenW, ScreenH - 64 - 120);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYWithdrawDetailCell class] forCellReuseIdentifier:LYWithdrawDetailCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self setUpBase];
    
    
    [self setUpTopView];
    
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提现详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
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
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = [NSString stringWithFormat:@"%.2f", [_withdrawItem.amt doubleValue]];
    topLabel.font = [UIFont systemFontOfSize:30.0];
    [self.view addSubview:topLabel];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(25);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    UILabel *info = [[UILabel alloc] init];
    if ([_withdrawItem.status isEqualToString:@"1"])
    {
        info.text = @"提现成功";
        info.textColor = RGB(126, 126, 126);
    }
    else
    {
        info.text = @"提现失败";
        info.textColor = [UIColor redColor];
    }
    
    [self.view addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(topLabel.bottom).offset(DCMargin);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info.bottom).offset(20);
        make.left.right.equalTo(0);
        make.height.equalTo(0.5);
    }];
}

#pragma mark - 消息数据
-(void)setUpData
{
    if ([_withdrawItem.status isEqualToString:@"1"])
    {
        _titleArr = @[@"提现金额", @"交易时间", @"交易状态", @"手续费"];
        NSString *money = [NSString stringWithFormat:@"%.2f", [_withdrawItem.amt doubleValue]];
        NSString *date = [DCSpeedy timeStampToStr:_withdrawItem.createTime];
        _infoArr = @[money, date, @"提现成功", @"2.00"];
    }
    else
    {
        _titleArr = @[@"提现金额", @"交易时间", @"交易状态", @"失败原因", @"收款账户"];
        NSString *money = [NSString stringWithFormat:@"%.2f", [_withdrawItem.amt doubleValue]];
        NSString *date = [DCSpeedy timeStampToStr:_withdrawItem.createTime];
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
        NSString *phoneStr = [NSString stringWithFormat:@"%@ 修改", phone];
        
        _infoArr = @[money, date, @"提现失败", @"", phoneStr];
    }
    
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWithdrawDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:LYWithdrawDetailCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _titleArr[indexPath.row];
    cell.infoLabel.text = _infoArr[indexPath.row];
    if (![_withdrawItem.status isEqualToString:@"1"])
    {
        if (indexPath.row == 2)
        {
            cell.infoLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 3)
        {
            cell.infoLabel.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 4)
        {
            [DCSpeedy ChangeColorString:@"修改" andLabel:cell.infoLabel andColor:[UIColor blueColor]];
        }
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_withdrawItem.status isEqualToString:@"1"])
    {
        if (indexPath.row == 3)
        {
            LYWalletServiceController *relateUsVc = [[LYWalletServiceController alloc] init];
            relateUsVc.urlString = @"http://api.047104086014.gaofangh.com/AboutUs/question1/details6.html";
            relateUsVc.title = @"失败原因";
            [self.navigationController pushViewController:relateUsVc animated:YES];
        }
        else if (indexPath.row == 4)
        {
            [self.navigationController pushViewController:[[LYAliccountController alloc] init] animated:YES];
        }
    }
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
