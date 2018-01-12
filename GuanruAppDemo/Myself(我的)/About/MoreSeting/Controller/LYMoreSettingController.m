//
//  LYMoreSettingController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMoreSettingController.h"
// Controllers
#import "LYChangePasswordController.h"
#import "LYLoginViewController.h"
#import "LYChangePhoneController.h"
#import "LYAliccountController.h"
// Models

// Views
#import "LYPersonlSettingCell.h"
// Vendors
#import "WJYAlertView.h"
// Categories

// Others

@interface LYMoreSettingController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;
//退出登录按钮
@property(nonatomic, strong) UIButton *quitBtn;
//版本label
@property(nonatomic, strong) UILabel *versionLabel;

@end

static NSString *const LYPersonlSettingCellID = @"LYPersonlSettingCell";

@implementation LYMoreSettingController

#pragma mark - LazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 20, ScreenW, ScreenH - DCTopNavH);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 30;
        [self.view addSubview:_tableView];
        
        //注册cell
        [_tableView registerClass:[LYPersonlSettingCell class] forCellReuseIdentifier:LYPersonlSettingCellID];
        
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpBottomView];
}

#pragma mark - initialize
-(void)setUpBase
{
    self.title = @"更多设置";
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 底部按钮
-(void)setUpBottomView
{
    _quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _quitBtn.backgroundColor = [UIColor whiteColor];
    _quitBtn.layer.cornerRadius = 8.0;
    _quitBtn.layer.masksToBounds = YES;
    [_quitBtn setTitle:@"退出登录" forState:0];
    [_quitBtn setTitleColor:RGB(222, 82, 108) forState:0];
    _quitBtn.titleLabel.font = PFR20Font;
    [self.view addSubview:_quitBtn];
    [_quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(245 - 4 + 60);
        make.height.equalTo(50);
    }];
    
    _versionLabel = [[UILabel alloc] init];
    _versionLabel.text = @"当前版本：v1.2.0";
    _versionLabel.textColor = RGB(152, 153, 154);
    _versionLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_versionLabel];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(_quitBtn.bottom).offset(25);
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYPersonlSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:LYPersonlSettingCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    if (indexPath.section == 0)
    {
        cell.type = cellTypeFour;
//        NSArray *titles = @[@"更换结算卡", @"更换手机号", @"修改密码"];
        cell.titleLabel.text = @"登录账户";
    
        if (str)
        {
            cell.infoLabel.text = str;
        }
        else
        {
            cell.infoLabel.text = @"暂无账户";
        }
        
        cell.setSwitch.hidden = YES;
    }
    else if (indexPath.section == 1)
    {
        NSArray *titles = @[@"更换手机号", @"修改密码", @"更换支付宝账号"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = titles[indexPath.row];
        cell.setSwitch.hidden = YES;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    footerView.backgroundColor = DCBGColor;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self.navigationController pushViewController:[[LYChangePasswordController alloc] init] animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self.navigationController pushViewController:[[LYChangePhoneController alloc] init] animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        [self.navigationController pushViewController:[[LYAliccountController alloc] init] animated:YES];
    }
    
}


#pragma mark - 点击事件
-(void)quitBtnClick
{
    
    __weak typeof(self) weakSelf = self;
    [WJYAlertView showTwoButtonsWithTitle:@"温馨提示" Message:@"是否要退出登录" ButtonType:WJYAlertViewButtonTypeWarn ButtonTitle:@"确定" Click:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //清空登录状态
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userphone"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userpassword"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useragent_no"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useralipayName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usermerchant_name"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useralipayaccount"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"publicKeyClient"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rate"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
        NSLog(@"点击取消");
    }];
    
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
