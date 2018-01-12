//
//  LYUpdateController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYUpdateController.h"
// Controllers

// Models

// Views
#import "LYUpdateOneCell.h"
#import "LYUpdateTwoCell.h"
#import "LYUpdateThreeCell.h"
// Vendors

// Categories

// Others

@interface LYUpdateController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *const LYUpdateOneCellID = @"LYUpdateOneCell";
static NSString *const LYUpdateTwoCellID = @"LYUpdateTwoCell";
static NSString *const LYUpdateThreeCellID = @"LYUpdateThreeCell";

@implementation LYUpdateController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 10, ScreenW, ScreenH - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.tableHeaderView = self.accountHeader;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYUpdateOneCell class] forCellReuseIdentifier:LYUpdateOneCellID];
        [_tableView registerClass:[LYUpdateTwoCell class] forCellReuseIdentifier:LYUpdateTwoCellID];
        [_tableView registerClass:[LYUpdateThreeCell class] forCellReuseIdentifier:LYUpdateThreeCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"我要升级";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *gridCell = nil;
    if (indexPath.section == 0)
    {
        LYUpdateOneCell *cell = [tableView dequeueReusableCellWithIdentifier:LYUpdateOneCellID];
        NSArray *titleArr = @[@"所有级别的费率表", @"盈利模式说明"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        gridCell = cell;
        
    }
    else if (indexPath.section == 1)
    {
        LYUpdateThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:LYUpdateThreeCellID];
        cell.titleLabel.text = @"员工 银联超大额隔天B 0.41%";
        cell.indicatorView.backgroundColor = RGB(79, 203, 224);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageNameView.image = [UIImage imageNamed:@"员工"];
        gridCell = cell;
    }
    else if (indexPath.section == 2)
    {
        LYUpdateTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:LYUpdateTwoCellID];
        cell.titleLabel.text = @"店长 银联超大额隔天B 0.38%";
        cell.infoLabel.text = @"邀请5人开通，或者累计收款金额达到30万元";
        cell.contentLabel.text = @"1000万交易，可赚3000.00分润";
        cell.indicatorView.backgroundColor = RGB(64, 196, 89);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageNameView.image = [UIImage imageNamed:@"店长"];
        gridCell = cell;
    }
    else if (indexPath.section == 3)
    {
        LYUpdateTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:LYUpdateTwoCellID];
        cell.titleLabel.text = @"老板 银联超大额隔天B 0.38%";
        cell.infoLabel.text = @"邀请10人开通，或者累计收款金额达到50万元";
        cell.contentLabel.text = @"1000万交易，可赚5000.00分润";
        cell.indicatorView.backgroundColor = RGB(252, 93, 97);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageNameView.image = [UIImage imageNamed:@"老板"];
        gridCell = cell;
    }
    else if (indexPath.section == 4)
    {
        LYUpdateThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:LYUpdateThreeCellID];
        cell.titleLabel.text = @"合伙人方案 请在线咨询客服";
        cell.indicatorView.backgroundColor = RGB(203, 55, 44);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageNameView.image = [UIImage imageNamed:@"合伙人"];
        gridCell = cell;
    }
    return gridCell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 35 : 90;
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
