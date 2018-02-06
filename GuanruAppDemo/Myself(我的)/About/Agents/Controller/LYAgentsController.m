//
//  LYAgentsController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/14.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYAgentsController.h"
// Controllers

// Models
#import "LYAgentItem.h"
// Views
#import "LYAgentsCell.h"
#import "BRPickerView.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
#import "RSAEncryptor.h"
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "UITextField+GFPlaceholder.h"
// Others

@interface LYAgentsController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UISearchBar *searchBar;

@property(nonatomic, strong) NSMutableArray<LYAgentItem *> *agentArr;

@property(nonatomic, assign) NSInteger page;

@property(nonatomic, strong) NSMutableArray *mutableArrModel;
//选择列数
@property(nonatomic, strong) NSMutableArray *mutableKeysArr;

//小额最大费率
@property(nonatomic, strong) NSString *maxRate;
//小额最小费率
@property(nonatomic, strong) NSString *minRate;
//小额费率间隔
@property(nonatomic, strong) NSString *interval;

//信用卡最大费率
@property(nonatomic, strong) NSString *maxCardRate;
//信用卡最小费率
@property(nonatomic, strong) NSString *minCardRate;
//信用卡费率间隔
@property(nonatomic, strong) NSString *cardInterval;


@end

static NSString *const LYAgentsCellID = @"LYAgentsCell";

@implementation LYAgentsController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 50, ScreenW, ScreenH - 64 - 50);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYAgentsCell class] forCellReuseIdentifier:LYAgentsCellID];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_tableView addGestureRecognizer:tap];
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
    [self setUpDataWithStr:self.searchBar.text];
    [self setUpRefreshHeader];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.title = @"代理商查询";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpSearchBar];
    self.tableView.backgroundColor = DCBGColor;
    self.page = 1;
}

#pragma mark - 设置搜索栏
-(void)setUpSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, DCMargin, ScreenW - 40, 40)];
    UIImage *searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    [_searchBar setBackgroundImage:searchBarBg];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"按口碑名称商家或者手机号搜索";
    [self.view addSubview:_searchBar];
}
    
#pragma mark 实现搜索条背景透明化
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 消息数据
-(void)setUpDataWithStr:(NSString *)string
{
    //    _gatherArr = [LYGatherItem mj_objectArrayWithFilename:@"Gather.plist"];
    NSString *allStr = nil;
    if (![DCSpeedy isBlankString:string])
    {
        allStr = string;
        self.mutableArrModel = nil;
    }
    else
    {
        allStr = @"0";
        self.mutableArrModel = nil;
    }
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"merName" : allStr,
                          @"pageIndex" : [NSString stringWithFormat:@"%ld", _page]
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetAgent Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            NSArray *arr = dic[@"list"];
            _agentArr = [LYAgentItem mj_objectArrayWithKeyValuesArray:arr];
            for(LYAgentItem *model in _agentArr)
            {
                [weakSelf.mutableArrModel addObject:model];
                
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.agentArr.count == 10)
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

-(void)setUpMoreDataWithStr:(NSString *)string
{
    //    _gatherArr = [LYGatherItem mj_objectArrayWithFilename:@"Gather.plist"];
    NSString *allStr = nil;
    if (![DCSpeedy isBlankString:string])
    {
        allStr = string;
//        self.mutableArrModel = nil;
    }
    else
    {
        allStr = @"0";
//        self.mutableArrModel = nil;
    }
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"merName" : allStr,
                          @"pageIndex" : [NSString stringWithFormat:@"%ld", _page]
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetAgent Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            NSArray *arr = dic[@"list"];
            _agentArr = [LYAgentItem mj_objectArrayWithKeyValuesArray:arr];
            for(LYAgentItem *model in _agentArr)
            {
                [weakSelf.mutableArrModel addObject:model];
                
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.agentArr.count == 10)
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.page = 1;
            self.mutableArrModel = nil;
            [self setUpDataWithStr:weakSelf.searchBar.text];
            [weakSelf.tableView reloadData];
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    //进入界面就开始刷新一下
//    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.page++;
            [weakSelf setUpMoreDataWithStr:weakSelf.searchBar.text];
            [weakSelf.tableView reloadData];
            
        });
    }];
    // 默认先隐藏footer
    self.tableView.mj_footer.hidden = NO;
    
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    LYAgentsCell *cell = [tableView dequeueReusableCellWithIdentifier:LYAgentsCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.agentItem = self.mutableArrModel[indexPath.row];
    
    cell.editBtnClickBlock = ^{
        NSLog(@"点击了编辑功能");
        LYAgentItem *item = weakSelf.mutableArrModel[indexPath.row];
        [weakSelf getAllChildRateWithid:item.id AndIndexPath:indexPath];
       
    };
    
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


#pragma mark - 点击事件
#pragma mark UISearchBar Delegate
//点击键盘上的search按钮时调用
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self setUpDataWithStr:searchBar.text];
}
//输入文本实时更新时调用
-(void)searchBar: (UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchText);
    [self setUpDataWithStr:searchText];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}

-(void)tap
{
    [self.view endEditing:YES];
}

//获取下级代理商的费率范围
-(void)getAllChildRateWithid:(NSString *)agid AndIndexPath:(NSIndexPath *)index
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:userid forKey:@"agentid"];
    [dic setValue:agid forKey:@"agentchild"];
    NSLog(@"%@", dic);
    [AFOwnerHTTPSessionManager getAddToken:GETAgentArea Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            self.mutableKeysArr = [NSMutableArray arrayWithCapacity:1];
            NSArray *allKeys = responseObject[@"Data"];
            
            for(NSString *key in allKeys)
            {
                if ([key isEqualToString:@"1001"])
                {
                    NSMutableArray *mutableRate = [NSMutableArray arrayWithCapacity:1];
                    _maxRate = responseObject[@"Data"][@"1001"][@"max"];
                    _minRate = responseObject[@"Data"][@"1001"][@"min"];
                    _interval = responseObject[@"Data"][@"1001"][@"interval"];
                    for (double i = [_maxRate doubleValue] * 100; i > [_minRate doubleValue] * 100 - [_interval doubleValue]; i = i - [_interval doubleValue])
                    {
                        NSString *pp = [NSString stringWithFormat:@"%lf", i];
                        NSString *str = [DCSpeedy changeFloat:pp];
                        NSString *strr = [NSString stringWithFormat:@"小额%@", str];
                        NSLog(@"%@", strr);
                        [mutableRate addObject:strr];
                    }
                    
                    NSString *cardStr = [[mutableRate lastObject] substringFromIndex:2];
                    NSString *numStr = [NSString stringWithFormat:@"%lf", [_minRate doubleValue] * 100];
                    NSString *cardStrr = [DCSpeedy changeFloat:numStr];
                    
                    if ([cardStrr doubleValue] == [cardStr doubleValue])
                    {
                        
                    }
                    else
                    {
                        [mutableRate removeLastObject];
                    }
                    
                    
                    [self.mutableKeysArr addObject:mutableRate];
                }
            }
            
            for(NSString *key in allKeys)
            {
                if ([key isEqualToString:@"1002"])
                {
                    
                }
            }
            
            for(NSString *key in allKeys)
            {
                if ([key isEqualToString:@"1003"])
                {
                    NSMutableArray *mutableRate = [NSMutableArray arrayWithCapacity:1];
                    _maxCardRate = responseObject[@"Data"][@"1003"][@"max"];
                    _minCardRate = responseObject[@"Data"][@"1003"][@"min"];
                    _cardInterval = responseObject[@"Data"][@"1003"][@"interval"];
                    NSLog(@"%lf,%lf", [_maxCardRate doubleValue], [_minCardRate doubleValue]);
                    if ([responseObject[@"Data"][@"1003"][@"IsDefault"] integerValue] == 0)
                    {
                        [mutableRate addObject:@"--"];
                    }
                    
                    for (double i = [_maxCardRate doubleValue] * 100; i > [_minCardRate doubleValue] * 100 - [_cardInterval doubleValue]; i = i - [_cardInterval doubleValue])
                    {
                        NSString *pp = [NSString stringWithFormat:@"%.1f", i];
                        NSString *str = [DCSpeedy changeFloat:pp];
                        NSString *strr = [NSString stringWithFormat:@"信用卡%@", str];
                        NSLog(@"%@", strr);
                        [mutableRate addObject:strr];
                    }
                    
                    NSString *cardStr = [[mutableRate lastObject] substringFromIndex:3];
                    NSString *numStr = [NSString stringWithFormat:@"%lf", [_minCardRate doubleValue] * 100];
                    NSString *cardStrr = [DCSpeedy changeFloat:numStr];
                    
                    if ([cardStr doubleValue] == [cardStrr doubleValue])
                    {
                        
                    }
                    else
                    {
                        [mutableRate removeLastObject];
                    }
                    
                    
                    [self.mutableKeysArr addObject:mutableRate];
                }
            }
            
            NSLog(@"%@", self.mutableKeysArr[0]);
            
            [self setUpChooseRateWith:agid AndIndex:index];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

-(void)setUpChooseRateWith:(NSString *)childId AndIndex:(NSIndexPath *)index
{
    
    //    double rate = [_currentRate doubleValue];
    __weak typeof(self) weakSelf = self;
    if (self.mutableKeysArr.count == 1)
    {
        [BRStringPickerView showStringPickerWithTitle:@"选择费率" dataSource:self.mutableKeysArr defaultSelValue:@[self.mutableKeysArr[0][0]] isAutoSelect:NO resultBlock:^(id selectValue) {
            NSLog(@"%@", selectValue[0]);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定是否要编辑下级代理商的费率?" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击确认");
                NSString *str = [NSString stringWithFormat:@"%@", [selectValue[0] substringFromIndex:2]];
                NSLog(@"%@", str);
                [weakSelf setAgentRateWith:childId andRate:str andCardRate:@"0" andIndex:index];
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
    else if (self.mutableKeysArr.count == 2)
    {
        [BRStringPickerView showStringPickerWithTitle:@"选择费率" dataSource:self.mutableKeysArr defaultSelValue:@[self.mutableKeysArr[0][0]] isAutoSelect:NO resultBlock:^(id selectValue) {
            NSLog(@"%@", selectValue[0]);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定是否要编辑下级代理商的费率?" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击确认");
                NSString *str = [NSString stringWithFormat:@"%@", [selectValue[0] substringFromIndex:2]];
                NSLog(@"%@", str);
                if ([selectValue[1] isEqualToString:@"--"])
                {
                    [weakSelf setAgentRateWith:childId andRate:str andCardRate:@"0" andIndex:index];
                }
                else
                {
                    NSString *strr = [NSString stringWithFormat:@"%@", [selectValue[1] substringFromIndex:3]];
                    [weakSelf setAgentRateWith:childId andRate:str andCardRate:strr andIndex:index];
                }
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
    }
    
}

-(void)setAgentRateWith:(NSString *)childId andRate:(NSString *)rate andCardRate:(NSString *)cardRate andIndex:(NSIndexPath *)index
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSString *public = [[NSUserDefaults standardUserDefaults] objectForKey:@"publicKeyClient"];
    
    NSString *pp = [NSString stringWithFormat:@"%lf", [rate doubleValue] * 0.01];
    NSString *str = [DCSpeedy changeFloat:pp];
    NSString *publicKey = [RSAEncryptor encryptString:str publicKey:public];
    
    NSString *cp = [NSString stringWithFormat:@"%lf", [cardRate doubleValue] * 0.01];
    NSString *cpStr = [DCSpeedy changeFloat:cp];
    NSString *cardPublicKey = [RSAEncryptor encryptString:cpStr publicKey:public];
    
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"agentchild" : childId,
                          @"Rate" : publicKey,
                          @"Rate_credit" : cardPublicKey
                          };
    NSLog(@"%@", dic);
    __weak typeof(self) weakSelf = self;
    [AFOwnerHTTPSessionManager getAddToken:SetAgentRate Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            LYAgentItem *item = weakSelf.mutableArrModel[index.row];
            item.rate_value = str;
            if ([cardRate isEqualToString:@"0"])
            {
                
            }
            else
            {
                item.credit_value = cpStr;
            }
            
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}


#pragma mark - 弹出是否编辑框
-(void)setUpAlerView
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定是否要编辑下级代理商的费率?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
