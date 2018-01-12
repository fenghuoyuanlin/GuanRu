//
//  LYPersonalViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYPersonalViewController.h"
// Controllers

// Models

// Views
#import "LYPersonlSettingCell.h"
#import "LYPersonalHeader.h"
// Vendors

// Categories

// Others

@interface LYPersonalViewController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LYPersonalHeader *personalHeader;

@end

static NSString *const LYPersonlSettingCellID = @"LYPersonlSettingCell";

@implementation LYPersonalViewController

#pragma mark - LazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //ios11情况下tableView上方会出现空白的解决方案
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [self.view addSubview:_tableView];
        
        //注册cell
        [_tableView registerClass:[LYPersonlSettingCell class] forCellReuseIdentifier:LYPersonlSettingCellID];
        
    }
    return _tableView;
}

-(LYPersonalHeader *)personalHeader
{
    if (!_personalHeader)
    {
        _personalHeader = [[LYPersonalHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    }
    return _personalHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

#pragma mark - initialize
-(void)setUpBase
{
    self.title = @"个人设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = DCBGColor;
    [self.view addSubview:self.personalHeader];
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYPersonlSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:LYPersonlSettingCellID];
    if (indexPath.row != 4)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *titles = @[@"头像", @"昵称", @"微信号", @"微信二维码", @"隐私开关"];
    cell.titleLabel.text = titles[indexPath.row];
    if (indexPath.row == 0)
    {
        cell.type = cellTypeTwo;
        [cell.imgViewBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else if (indexPath.row == 3)
    {
        cell.type = cellTypeThree;
        [cell.imgViewBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else if (indexPath.row == 4)
    {
        cell.type = cellTypeOne;
        cell.setSwitch.on = NO;
    }
    else
    {
        cell.setSwitch.hidden = YES;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0) ? 100 : 60;
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
