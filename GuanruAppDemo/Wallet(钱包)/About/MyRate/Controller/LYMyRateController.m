//
//  LYMyRateController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/30.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyRateController.h"
// Controllers

// Models
#import "LYRateItem.h"
// Views
#import "LYRateItemCell.h"
#import "LYRateHeader.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories

// Others

@interface LYMyRateController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LYRateHeader *rateHeader;

@property(nonatomic, strong) NSMutableArray<LYRateItem *> *rateArr;

@end

static NSString *const LYRateItemCellID = @"LYRateItemCell";

@implementation LYMyRateController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 100, ScreenW, ScreenH - 100 - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.tableHeaderView = self.accountHeader;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerNib:[UINib nibWithNibName:@"LYRateItemCell" bundle:nil] forCellReuseIdentifier:LYRateItemCellID];
    }
    return _tableView;
}

-(LYRateHeader *)rateHeader
{
    if (!_rateHeader)
    {
        _rateHeader = [[LYRateHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
        __weak typeof(self) weakSelf = self;
        
        _rateHeader.recommendClickBlock = ^{
            NSLog(@"点击了当面付");
            [weakSelf setUpData];
            
        };
        _rateHeader.priceClickBlock = ^{
            NSLog(@"点击了微信支付");
            _rateArr = nil;
            [weakSelf setUpWeChatData];
        };
        _rateHeader.salesClickBlock = ^{
            NSLog(@"点击了QQ钱包");
            [weakSelf setUpQQData];
        };
        _rateHeader.filtrateClickBlock = ^{//点击了筛选
            NSLog(@"点击了京东钱包");
            [weakSelf setUpJingdongData];
        };
    }
    return _rateHeader;
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
    self.title = @"我的费率";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
    [self.view addSubview:self.rateHeader];
}

#pragma mark - 当面付数据
-(void)setUpData
{
    _rateArr = nil;
    _rateArr = [LYRateItem mj_objectArrayWithFilename:@"RateItem.plist"];
    [self.tableView reloadData];
}
#pragma mark - 微信数据
-(void)setUpWeChatData
{
    _rateArr = nil;
    _rateArr = [LYRateItem mj_objectArrayWithFilename:@"RateItem2.plist"];
    [self.tableView reloadData];
}
#pragma mark - QQ数据
-(void)setUpQQData
{
    _rateArr = nil;
    _rateArr = [LYRateItem mj_objectArrayWithFilename:@"RateItem3.plist"];
    [self.tableView reloadData];
}
#pragma mark - 京东数据
-(void)setUpJingdongData
{
    _rateArr = nil;
    _rateArr = [LYRateItem mj_objectArrayWithFilename:@"RateItem4.plist"];
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRateItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRateItemCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rateItem = _rateArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
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
