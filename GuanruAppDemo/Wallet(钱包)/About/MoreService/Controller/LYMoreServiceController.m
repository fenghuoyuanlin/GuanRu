//
//  LYMoreServiceController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMoreServiceController.h"
// Controllers

// Models
#import "LYCreditItem.h"
// Views
#import "LYCreditCardCell.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories

// Others

@interface LYMoreServiceController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYCreditItem *> *creditArr;

@end

static NSString *const LYCreditCardCellID = @"LYCreditCardCell";

@implementation LYMoreServiceController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYCreditCardCell class] forCellReuseIdentifier:LYCreditCardCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    self.title = @"更多服务";
}

#pragma mark - 信用卡数据
-(void)setUpData
{
    _creditArr = [LYCreditItem mj_objectArrayWithFilename:@"MoreService.plist"];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _creditArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYCreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:LYCreditCardCellID];
    cell.creditItem = _creditArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
