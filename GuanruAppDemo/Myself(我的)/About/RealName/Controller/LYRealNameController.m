//
//  LYRealNameController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYRealNameController.h"
// Controllers

// Models

// Views
#import "LYPersonlSettingCell.h"
// Vendors

// Categories

// Others

@interface LYRealNameController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;

@end

static NSString *const LYPersonlSettingCellID = @"LYPersonlSettingCell";

@implementation LYRealNameController

#pragma mark - LazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCTopNavH);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 30;
        [self.view addSubview:_tableView];
        
        //注册cell
        [_tableView registerClass:[LYPersonlSettingCell class] forCellReuseIdentifier:LYPersonlSettingCellID];
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

#pragma mark - initialize
-(void)setUpBase
{
    self.title = @"我的资料";
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYPersonlSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:LYPersonlSettingCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = cellTypeFour;
    cell.infoLabel.text = @"未完善";
    NSArray *titles = @[@"身份证认证", @"银行卡认证", @"安全支付认证"];
    cell.titleLabel.text = titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
//        [self.navigationController pushViewController:[[XLIDScanViewController alloc] init] animated:YES];
    }
    else if (indexPath.row == 1)
    {
//        [self.navigationController pushViewController:[[XLBankScanViewController alloc] init] animated:YES];
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
