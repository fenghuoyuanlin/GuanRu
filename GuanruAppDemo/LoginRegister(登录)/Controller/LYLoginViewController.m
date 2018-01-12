//
//  LYLoginViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/20.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYLoginViewController.h"
// Controllers
#import "LYRegisterViewController.h"
#import "LYPassWordController.h"
// Models
#import "LYRegisterItem.h"
// Views
#import "LYLoginCell.h"
#import "LYLIRLButton.h"
// Vendors
#import <MJExtension.h>
#import "MBProgressHUD.h"
#import "RSAEncryptor.h"
// Categories
#import "NSObject+Property.h"
// Others

@interface LYLoginViewController ()<UITableViewDelegate, UITableViewDataSource>

//tableView
@property(nonatomic, strong) UITableView *tableView;
//数据数组
@property(nonatomic, strong) NSMutableArray<LYRegisterItem *> *loginArr;
//返回按钮
@property(nonatomic, strong) UIButton *backBtn;
//标题图片
@property(nonatomic, strong) UIImageView *titleImgView;
//用户登录
@property(nonatomic, strong) UILabel *lgLabel;

//存储tableView的所有NSIndexPath,以便在其他地方可以自由调取对应的cell
@property(nonatomic, strong) NSMutableArray *indexPathArr;
//登录按钮
@property(nonatomic, strong) UIButton *loginBtn;
//记住密码按钮
@property(nonatomic, strong) LYLIRLButton *rememberBtn;
//忘记密码按钮
@property(nonatomic, strong) UIButton *forgetBtn;
//新用户注册
@property(nonatomic, strong) UIButton *UserRegister;
//底部标题
@property(nonatomic, strong) UILabel *bottomLabel;
//是否打勾
@property(nonatomic, assign) BOOL isTick;

@property(nonatomic, strong) NSString *publicKey;

@end

static NSString *const LYLoginCellID = @"LYLoginCell";

@implementation LYLoginViewController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(15, 160, ScreenW - 30, 120);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYLoginCell class] forCellReuseIdentifier:LYLoginCellID];
    }
    return _tableView;
}

-(NSMutableArray *)indexPathArr
{
    if (!_indexPathArr)
    {
        _indexPathArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _indexPathArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    //改变记住密码按钮的图片状态
//    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"remarkIphone"];
//    NSLog(@"%@", phone);
//    if (phone)
//    {
//        _rememberBtn.selected = _isTick;
//        [self rememberBtnClick:_rememberBtn];
//        
//    }
//    else
//    {
//        _isTick = !_isTick;
//        _rememberBtn.selected = _isTick;
//        [self rememberBtnClick:_rememberBtn];
//    }
    
    //清空登录状态
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userToken"];
    [[NSUserDefaults standardUserDefaults] setObject:@"uid" forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userphone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userpassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useragent_no"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useralipayName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"useralipayaccount"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usermerchant_name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"publicKeyClient"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rate"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setUpData];
    [self setUpFalseNavAndBottom];
}

#pragma mark - 注册界面数据
-(void)setUpData
{
    _loginArr = [LYRegisterItem mj_objectArrayWithFilename:@"LoginNote.plist"];
}

#pragma mark - 假的导航栏
-(void)setUpFalseNavAndBottom
{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _backBtn.backgroundColor = [UIColor redColor];
    [_backBtn setImage:[UIImage imageNamed:@"箭头2"] forState:0];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%lf", ScreenH);
   
    _lgLabel = [[UILabel alloc] init];
    _lgLabel.text = @"用户登录";
    _lgLabel.font = PFR20Font;
    _lgLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lgLabel];
    
    
    _titleImgView = [[UIImageView alloc] init];
//    _titleImgView.backgroundColor = [UIColor greenColor];
    _titleImgView.image = [UIImage imageNamed:@"资源 1"];
    [self.view addSubview:_titleImgView];
    //iphonex的适配
    if (ScreenH > 770.0)
    {
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(DCMargin);
            make.top.equalTo(40);
            make.size.equalTo(CGSizeMake(25, 25));
        }];
        
        [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.top.equalTo(64);
            make.size.equalTo(CGSizeMake(ScreenW - 30, ScreenW - 30));
        }];
        
        [_lgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(100);
            make.centerX.equalTo(self.view.centerX);
        }];
    }
    else
    {
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(DCMargin);
            make.top.equalTo(30);
            make.size.equalTo(CGSizeMake(25, 25));
        }];
        
        [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.top.equalTo(64);
            make.size.equalTo(CGSizeMake(ScreenW - 30, ScreenW - 30));
        }];
        
        [_lgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(90);
            make.centerX.equalTo(self.view.centerX);
        }];
    }
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = RGBA(50, 112, 229, 1.0);
    _loginBtn.layer.cornerRadius = 20.0;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn setTitle:@"登录" forState:0];
    _loginBtn.titleLabel.font = PFR18Font;
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(305);
        make.height.equalTo(45);
    }];
    
//    _rememberBtn = [LYLIRLButton buttonWithType:UIButtonTypeCustom];
//    [_rememberBtn setTitle:@"记住密码" forState:0];
//    _rememberBtn.adjustsImageWhenHighlighted = NO;
//    [_rememberBtn setImage:[UIImage imageNamed:@"用户协议icon"] forState:0];
//    [_rememberBtn setImage:[UIImage imageNamed:@"用户协议icon2"] forState:UIControlStateSelected];
//    _rememberBtn.titleLabel.font = PFR14Font;
//    [_rememberBtn setTitleColor:RGB(175, 175, 175) forState:0];
//    [self.view addSubview:_rememberBtn];
//
//    [_rememberBtn addTarget:self action:@selector(rememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [_rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(15);
//        make.top.equalTo(_loginBtn.bottom).offset(15);
//        make.size.equalTo(CGSizeMake(80, 25));
//    }];
    
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetBtn setTitle:@"忘记密码?" forState:0];
    _forgetBtn.titleLabel.font = PFR14Font;
    [_forgetBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:_forgetBtn];
    
    [_forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.top.equalTo(_loginBtn.bottom).offset(15);
        make.size.equalTo(CGSizeMake(80, 25));
    }];
    
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.text = @"客服电话：400-0687-666";
    _bottomLabel.textColor = RGB(92, 201, 218);
    [self.view addSubview:_bottomLabel];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(-25);
    }];
    
    _UserRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [_UserRegister setTitle:@"新用户注册" forState:0];
    [_UserRegister setTitleColor:RGB(92, 201, 218) forState:0];
    [self.view addSubview:_UserRegister];
    
    [_UserRegister addTarget:self action:@selector(UserRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_UserRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(_bottomLabel.top).offset(-15);
        make.size.equalTo(CGSizeMake(120, 25));
    }];
    //先隐藏，必要时再打开
    _UserRegister.hidden = YES;
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _loginArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:LYLoginCellID];
    if (indexPath.row == 1)
    {
        cell.textField.secureTextEntry = YES;
    }
    else if (indexPath.row == 0)
    {
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"remarkIphone"];
        if (phone)
        {
            cell.textField.text = phone;
        }
    }
        
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.registerItem = _loginArr[indexPath.row];
    
    [self.indexPathArr addObject:indexPath];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - 点击事件

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginBtnClick
{
    __weak typeof(self) weakSelf = self;
    LYLoginCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    NSLog(@"%@", cellOne.textField.text);
    NSDictionary *dic = @{
                          @"phone": cellOne.textField.text
                          };
    [AFOwnerHTTPSessionManager get:GetSecretKey Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *str = responseObject[@"code"];
        
        if ([str isEqualToString:@"0000"])
        {
            NSDictionary *dic = responseObject[@"Data"];
            NSString *publicClient = dic[@"publicKeyClient"];
            _publicKey = publicClient;
            [[NSUserDefaults standardUserDefaults] setObject:publicClient forKey:@"publicKeyClient"];
            [weakSelf loginDetailClick];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

-(void)loginDetailClick
{
    LYLoginCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    NSLog(@"%@", cellOne.textField.text);
    LYLoginCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    NSLog(@"%@", cellTwo.textField.text);
    NSString *registration = [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
    NSString *registerationStr = [NSString stringWithFormat:@"%@", registration];
    NSLog(@"%@***********", registration);
    NSString *publicKey = [RSAEncryptor encryptString:cellTwo.textField.text publicKey:_publicKey];
    //判断手机号是否是正确的手机格式
    if ([DCSpeedy valiMobile:cellOne.textField.text])
    {
        if (![DCSpeedy isBlankString:cellTwo.textField.text])
        {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:cellOne.textField.text forKey:@"phone"];
            [dic setValue:publicKey forKey:@"pwd"];
            [dic setValue:registerationStr forKey:@"registeredid"];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [AFOwnerHTTPSessionManager get:LoginAccount Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@", responseObject);
                NSString *str = responseObject[@"code"];
                if ([str isEqualToString:@"0000"])
                {
                    NSDictionary *dic = responseObject[@"Data"];
                    NSLog(@"%@", dic[@"token"]);
                    //标记登录状态
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"token"] forKey:@"userToken"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"id"] forKey:@"userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"phone"] forKey:@"userphone"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"password"] forKey:@"userpassword"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"agent_no"] forKey:@"useragent_no"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"alipayName"] forKey:@"useralipayName"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"alipayaccount"] forKey:@"useralipayaccount"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"merchant_name"] forKey:@"usermerchant_name"];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:cellOne.textField.text forKey:@"remarkIphone"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    //异步发通知
                    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"fixMyselfHeader" object:nil];
                    });
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                    
                }
                else
                {
                    //隐藏菊花
                    [hud hideAnimated:YES];
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
                
            }];
        }
        else
        {
            [DCSpeedy alertMes:@"请输入密码"];
        }
       
    }
    else
    {
        [DCSpeedy alertMes:@"请输入正确的手机号"];
    }
    
}

//-(void)rememberBtnClick:(UIButton *)sender
//{
//    sender.selected = !sender.selected;
//    if (sender.selected)
//    {
//        NSLog(@"打勾");
//        _isTick = sender.selected;
//    }
//    else
//    {
//        NSLog(@"取消打勾");
//        _isTick = sender.selected;
//    }
//}

-(void)forgetBtnClick
{
    [self.navigationController pushViewController:[[LYPassWordController alloc] init] animated:YES];
}

-(void)UserRegisterClick
{
    [self.navigationController pushViewController:[[LYRegisterViewController alloc] init] animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBar.hidden = NO;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
