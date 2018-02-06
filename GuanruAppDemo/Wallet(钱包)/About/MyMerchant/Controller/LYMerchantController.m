//
//  LYMerchantController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMerchantController.h"
// Controllers
#import "LYPaymentDetailController.h"
#import "LYGatheringController.h"
// Models
#import "LYMerchantModel.h"
// Views
#import "LYProfitBottom.h"
// Vendors
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface LYMerchantController ()

@property(nonatomic, strong) LYProfitBottom *bottomView;

@property(nonatomic, strong) LYMerchantModel *merchantModel;

@property(nonatomic, strong) UILabel *bottomInfoLabel;

@property(nonatomic, strong) UILabel *bottomMoney;

@property(nonatomic, strong) UIView *gatherView;
//冻结View消失或者隐藏
@property(nonatomic, assign) double signLength;

@end

@implementation LYMerchantController

#pragma mark - lazyLoad

-(LYProfitBottom *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[LYProfitBottom alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
        __weak typeof(self) weakSelf = self;
        _bottomView.accountBtnClickBlock = ^{
            NSLog(@"点击了结算按钮");
            [weakSelf rightLogin];
        };
    }
    return _bottomView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor whiteColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR20Font;
    self.navigationController.navigationBar.barTintColor = RGBA(50, 112, 229, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR20Font;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCBGColor;
    self.title = @"我的账户";
    [self.view addSubview:self.bottomView];
    [self setUpMerchantData];
//    [self setUpNav];
    
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"明细" forState:0];
    button.frame = CGRectMake(0, 0, 40, 22);
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.titleLabel.font = PFR14Font;
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 设置底部Label
-(void)setUpBottomLabel
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _signLength, ScreenW, 30)];
    view.backgroundColor = DCBGColor;
    [self.view addSubview:view];
    
    UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _signLength, 120, 30)];
    leftlabel.font = PFR14Font;
    leftlabel.text = @"近30天交易记录";
    [self.view addSubview:leftlabel];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(ScreenW - 120, _signLength, 120, 30);
    [rightBtn setTitle:@"查看更多>>" forState:0];
    rightBtn.titleLabel.font = PFR14Font;
    [rightBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _gatherView = [[UIView alloc] init];
    _gatherView.frame = CGRectMake(0, _signLength + 30, ScreenW, ScreenH - 30 - _signLength - 64);
    [self.view addSubview:_gatherView];
    LYGatheringController *gatherVC = [[LYGatheringController alloc] init];
    gatherVC.height = ScreenH - 230 - 64;
    [_gatherView addSubview:gatherVC.view];
}

#pragma mark - 获取数据
-(void)setUpMerchantData
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid
                          };
    __weak typeof(self) weakSelf = self;
    [AFOwnerHTTPSessionManager getAddToken:GetAccountBalance Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            weakSelf.merchantModel = [LYMerchantModel mj_objectWithKeyValues:dic];
            NSLog(@"%@", _merchantModel.amt);
            weakSelf.bottomView.numLabel.text = [NSString stringWithFormat:@"%.2f", [_merchantModel.amt doubleValue]];
            NSString *totalStr = [NSString stringWithFormat:@"%.2f", [_merchantModel.deposit doubleValue]];
            weakSelf.bottomView.totalMoney.text = [NSString stringWithFormat:@"总收益：%@", totalStr];
            //判断用户是否冻结金额
            if ([weakSelf.merchantModel.isLock isEqualToString:@"1"])
            {
                weakSelf.bottomView.freezeMoneyLabel.text = [NSString stringWithFormat:@"%.2f", [_merchantModel.frozenamt doubleValue]];
                _signLength = 200;
                [self setUpBottomLabel];
            }
            else
            {
                weakSelf.bottomView.bottomView.hidden = YES;
                _signLength = 180;
                [self setUpBottomLabel];
            }
        }
        else
        {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

#pragma mark - 点击事件
-(void)rightBarClick
{
    NSLog(@"点击了付款明细");
    [self.navigationController pushViewController:[[LYPaymentDetailController alloc] init] animated:YES];
}

#pragma mark - 温馨提示
-(void)rightLogin
{
    __weak typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"本次提现手续费2元，确定要结算账户上的余额%@元吗?", [NSString stringWithFormat:@"%.2f", [_merchantModel.amt doubleValue]]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        [weakSelf setUpCloseAccount];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 我要结算
-(void)setUpCloseAccount
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"money" : self.bottomView.numLabel.text
                          };

    [AFOwnerHTTPSessionManager getAddToken:Withdrawal Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            weakSelf.bottomView.numLabel.text = @"0.00";
            [DCSpeedy alertMes:@"提现成功"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)moreBtnClick
{
    [self.navigationController pushViewController:[[LYPaymentDetailController alloc] init] animated:YES];
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
