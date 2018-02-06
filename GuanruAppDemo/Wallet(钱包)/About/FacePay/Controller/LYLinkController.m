//
//  LYLinkController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYLinkController.h"
// Controllers
#import "LYQrcodeController.h"
#import "LYFacePayController.h"
// Models
#import "LYLinkItem.h"
// Views
#import "LYLinkCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface LYLinkController ()<UITableViewDelegate, UITableViewDataSource>
//tableView
@property(nonatomic, strong) UITableView *tableView;
//数据模型
@property(nonatomic, strong) NSMutableArray<LYLinkItem *> *linkArr;
//底部view
@property(nonatomic, strong) UIView *bottomView;
//底部Btn
@property(nonatomic, strong) UIButton *bottomBtn;
//接收通知
@property(nonatomic, weak) id lyObsever;

@end

static NSString *const LYLinkCellID = @"LYLinkCell";

@implementation LYLinkController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64 - 45);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYLinkCell class] forCellReuseIdentifier:LYLinkCellID];
    }
    return _tableView;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [self setUpData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self setUpBottomView];
    [self acceptanceNote];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
}

#pragma mark - 创建底部按钮
-(void)setUpBottomView
{
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-KSafeBarHeight);
        make.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.layer.cornerRadius = 15.0;
    _bottomBtn.layer.masksToBounds = YES;
    [_bottomBtn setImage:[UIImage imageNamed:@"添加"] forState:0];
    [_bottomBtn setTitle:@"新增收款码" forState:0];
    [_bottomBtn setBackgroundColor:RGB(45, 123, 234)];
    [self.view addSubview:_bottomBtn];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(_bottomView.top).offset(7.5);
        make.bottom.equalTo(_bottomView.bottom).offset(-7.5);
        make.right.equalTo(-15);
    }];
}

#pragma mark - 接收通知
-(void)acceptanceNote
{
    __weak typeof(self) weakSelf = self;
    
    _lyObsever = [[NSNotificationCenter defaultCenter] addObserverForName:@"addUrl" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf setUpData];
    }];
}

#pragma mark - 消息数据
-(void)setUpData
{
//    _linkArr = [LYLinkItem mj_objectArrayWithFilename:@"LinkItem.plist"];

    __weak typeof(self) weakSelf = self;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"productid" : _judeCode
                          };
    NSLog(@"%@", dic);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFOwnerHTTPSessionManager getAddToken:GetShopList Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSArray *arr = [responseObject objectForKey:@"Data"];
            _linkArr = [LYLinkItem mj_objectArrayWithKeyValuesArray:arr];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [hud hideAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [hud hideAnimated:YES];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _linkArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:LYLinkCellID];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.linkItem = _linkArr[indexPath.row];
    [cell.commenBtn setTitle:([_judeCode isEqualToString:@"1001"]) ? @"小额商户" : ([_judeCode isEqualToString:@"1002"] ? @"大额商户" : @"信用卡商户") forState:0];
    __weak typeof(self) weakSelf = self;
    cell.openClickBlock = ^{
        NSLog(@"点击了打开");
        [weakSelf openUrlWithShopid:_linkArr[indexPath.row].id andNsintenger:indexPath.row];
    };
    cell.delegateBtnClickBlock = ^{
        NSLog(@"点击了删除");
        //删除提醒
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要删除这条信息？" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击确认");
            [weakSelf delegateUrlWithShopid:_linkArr[indexPath.row].id];
            [_linkArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
        }]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    return cell;
}


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 点击事件
-(void)bottomBtnClick
{
    NSLog(@"点击了新增按钮");
    LYFacePayController *tempVC = [[LYFacePayController alloc] init];
    tempVC.isJudgeCode = _judeCode;
    [self.navigationController pushViewController:tempVC animated:YES];
}


#pragma mark - 打开或者删除
-(void)openUrlWithShopid:(NSString *)shopid andNsintenger:(NSInteger )row
{
    NSDictionary *dic = @{
                          @"shopid": shopid,
                          @"productid" : _judeCode
                          };
    __weak typeof(self) weakSelf = self;
    [AFOwnerHTTPSessionManager getAddToken:GetUrlQrCode Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"Data"];
        LYQrcodeController *qrVC = [[LYQrcodeController alloc] init];
        qrVC.codeStr = dic[@"url"];
        qrVC.storeStr = _linkArr[row].shop_name;
        [weakSelf.navigationController pushViewController:qrVC animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)delegateUrlWithShopid:(NSString *)shopid
{
    NSDictionary *dic = @{
                          @"shopid": shopid,
                          @"productid" : _judeCode
                          };
    
    [AFOwnerHTTPSessionManager getAddToken:DelShopping Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - 销毁观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_lyObsever];
}

#pragma mark - 点击事件
-(void)rightDelegateClick
{
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要清空里面的所有信息？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
