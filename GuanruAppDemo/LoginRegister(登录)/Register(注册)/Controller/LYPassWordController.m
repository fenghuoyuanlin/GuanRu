//
//  LYPassWordController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/4.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYPassWordController.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views
#import "LYRegisterCell.h"
#import "LYLIRLButton.h"
#import "CountdownButton.h"
#import "JKCountDownButton.h"
// Vendors
#import <MJExtension.h>
#import "RSAEncryptor.h"
// Categories

// Others

@interface LYPassWordController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

//tableView
@property(nonatomic, strong) UITableView *tableView;
//数据数组
@property(nonatomic, strong) NSMutableArray<LYRegisterItem *> *registerArr;
//返回按钮
@property(nonatomic, strong) UIButton *backBtn;
//内容标题
@property(nonatomic, strong) UILabel *titleLabel;

//获取二维码按钮
@property(nonatomic, strong) JKCountDownButton *verCodeBtn;

@property(nonatomic, strong) LYRegisterCell *registerCell;
//存储tableView的所有NSIndexPath,以便在其他地方可以自由调取对应的cell
@property(nonatomic, strong) NSMutableArray *indexPathArr;
//用户注册协议按钮
@property(nonatomic, strong) LYLIRLButton *userRegisterBtn;
//注册按钮
@property(nonatomic, strong) UIButton *registerBtn;

@property(nonatomic, strong) NSString *publicKey;

@end

static NSString *const LYRegisterCellID = @"LYRegisterCell";

@implementation LYPassWordController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(15, 120 - 84, ScreenW - 30, 240);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYRegisterCell class] forCellReuseIdentifier:LYRegisterCellID];
    }
    return _tableView;
}

-(UIButton *)verCodeBtn
{
    if (!_verCodeBtn)
    {
        
        _verCodeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        _verCodeBtn.frame = CGRectMake(ScreenW - 135, 12, 100, 36);
        [_verCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verCodeBtn.backgroundColor = BacColor;
        _verCodeBtn.titleLabel.font = PFR14Font;
        _verCodeBtn.layer.cornerRadius = 8.0;
        _verCodeBtn.layer.masksToBounds = YES;
        [self.view addSubview:_verCodeBtn];
        
        __weak typeof(self) weakSelf = self;
        [_verCodeBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            
            LYRegisterCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
            if ([DCSpeedy valiMobile:cell.textField.text])
            {
                [weakSelf verCodeBtnClick];
                weakSelf.verCodeBtn.backgroundColor = SelColor;
                sender.enabled = NO;
                [sender startCountDownWithSecond:60];
                [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                    return title;
                }];
                [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES;
                    countDownButton.backgroundColor = BacColor;
                    return @"重新发送";
                    
                }];
            }
            else
            {
                [DCSpeedy alertMes:@"请输入正确的手机号"];
            }
            
        }];
        
//        _verCodeBtn = [[CountdownButton alloc] initWithFrame:CGRectMake(ScreenW - 135, 12, 100, 36) title:@"获取验证码" startTime:60 tapEvent:^{
//            NSLog(@"tap");
//        } callBack:^{
//            NSLog(@"complete");
//        }];
        
//        [_verCodeBtn setTitle:@"获取验证码" forState:0];
//        [_verCodeBtn addTarget:self action:@selector(verCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _verCodeBtn;
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
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setUpFalseNavAndBottom];
    [self setUpData];
}

#pragma mark - 假的导航栏
-(void)setUpFalseNavAndBottom
{
    //    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _backBtn.backgroundColor = [UIColor redColor];
    //    [_backBtn setImage:[UIImage imageNamed:@"箭头2"] forState:0];
    //    [self.view addSubview:_backBtn];
    //    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(DCMargin);
    //        make.top.equalTo(25);
    //        make.size.equalTo(CGSizeMake(25, 25));
    //    }];
    
    //    _titleLabel = [[UILabel alloc] init];
    //    _titleLabel.text = @"快速注册";
    //    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:_titleLabel];
    //
    //    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(25);
    //        make.centerX.equalTo(self.view.centerX);
    //    }];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.backgroundColor = RGBA(50, 112, 229, 1.0);
    _registerBtn.layer.cornerRadius = 20.0;
    _registerBtn.layer.masksToBounds = YES;
    [_registerBtn setTitle:@"提交" forState:0];
    _registerBtn.titleLabel.font = PFR18Font;
    [self.view addSubview:_registerBtn];
    [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(360 - 84 + 30);
        make.height.equalTo(45);
    }];
    
//    _userRegisterBtn = [LYLIRLButton buttonWithType:UIButtonTypeCustom];
//    [_userRegisterBtn setTitle:@"用户注册协议" forState:0];
//    _userRegisterBtn.adjustsImageWhenHighlighted = NO;
//    [_userRegisterBtn setImage:[UIImage imageNamed:@"用户协议icon2"] forState:0];
//    _userRegisterBtn.titleLabel.font = PFR14Font;
//    [_userRegisterBtn setTitleColor:RGB(244, 200, 79) forState:0];
//    [self.view addSubview:_userRegisterBtn];
//    [_userRegisterBtn addTarget:self action:@selector(userRegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [_userRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_registerBtn.bottom).offset(15);
//        make.left.equalTo(15);
//        make.size.equalTo(CGSizeMake(120, 30));
//    }];
    
}

#pragma mark - 注册界面数据
-(void)setUpData
{
    _registerArr = [LYRegisterItem mj_objectArrayWithFilename:@"ForgetNote.plist"];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _registerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRegisterCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.registerItem = _registerArr[indexPath.row];
    
    [self.indexPathArr addObject:indexPath];
    if (indexPath.row == 1)
    {
        [cell addSubview:self.verCodeBtn];
    }
    else if (indexPath.row == 2 ||  indexPath.row == 3)
    {
        cell.textField.delegate = self;
        cell.textField.secureTextEntry = YES;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - 点击事件

#pragma mark - 点击验证码按钮
-(void)verCodeBtnClick
{
    NSLog(@"点击了验证码");
    LYRegisterCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    NSLog(@"%@", cell.textField.text);
   
        NSDictionary *dic = @{
                              @"phone": cell.textField.text,
                              @"ipAddress": @"",
                              @"blackbox" : @"",
                              @"type" :@"1"
                              };
        
        [AFOwnerHTTPSessionManager getAddToken:RegisterCode Parameters:dic
                                       success:^(NSURLSessionDataTask *task, id responseObject) {
                                           NSLog(@"%@", responseObject);
                                           [DCSpeedy alertMes:@"发送成功"];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           NSLog(@"%@", error);
                                       }];
   
    
}

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 提交按钮审核
-(void)registerBtnClick
{
    __weak typeof(self) weakSelf = self;
    LYRegisterCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
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
            [weakSelf registerBtnDetailClick];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
    
}

-(void)registerBtnDetailClick
{
    LYRegisterCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    LYRegisterCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    LYRegisterCell *cellThree = [self.tableView cellForRowAtIndexPath:self.indexPathArr[2]];
    LYRegisterCell *cellFour = [self.tableView cellForRowAtIndexPath:self.indexPathArr[3]];
    
    if (![DCSpeedy isBlankString:cellThree.textField.text] && ![DCSpeedy isBlankString:cellFour.textField.text] && ![DCSpeedy isBlankString:cellTwo.textField.text])
    {
        if ([cellThree.textField.text isEqualToString:cellFour.textField.text])
        {
            if (cellThree.textField.text.length >= 6)
            {
                NSString *publicKey = [RSAEncryptor encryptString:cellThree.textField.text publicKey:_publicKey];
                __weak typeof(self) weakSelf = self;
                NSDictionary *dic = @{
                                      @"phone": cellOne.textField.text,
                                      @"VerificationCode" : cellTwo.textField.text,
                                      @"NewPwd" : publicKey
                                      };
                
                [AFOwnerHTTPSessionManager getAddToken:ForgetPassWord Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@", responseObject);
                    NSString *code = responseObject[@"code"];
                    if ([code isEqualToString:@"0000"])
                    {
                        [DCSpeedy alertMes:@"修改成功"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        });
                    }
                    else
                    {
                        
                    }
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@", error);
                    
                }];
            }
            else
            {
                [DCSpeedy alertMes:@"密码至少为6位数"];
            }
        }
        else
        {
            [DCSpeedy alertMes:@"两次新密码不一样"];
        }
    }
    else
    {
        [DCSpeedy alertMes:@"新密码或验证码不能为空"];
    }
    
    
}

-(void)userRegisterBtnClick:(UIButton *)sender
{
    NSLog(@"点击了用户协议");
}

#pragma mark - 视图消失销毁定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [_verCodeBtn stopTimer];
}

#pragma mark - - shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制输入的内容只能为数字和字母
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark - 点击屏幕退出键盘
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
