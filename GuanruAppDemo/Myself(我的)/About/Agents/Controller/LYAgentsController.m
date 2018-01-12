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
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
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
    _searchBar.placeholder = @"按口碑名称商家搜索";
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.page++;
            [weakSelf setUpDataWithStr:weakSelf.searchBar.text];
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
    LYAgentsCell *cell = [tableView dequeueReusableCellWithIdentifier:LYAgentsCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.agentItem = self.mutableArrModel[indexPath.row];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
