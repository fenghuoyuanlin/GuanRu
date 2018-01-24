//
//  LYAliccountController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/3.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYAliccountController.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views
#import "LYFillDataCell.h"
// Vendors
#import <MJExtension.h>
 #import "RSAEncryptor.h"
// Categories

// Others

@interface LYAliccountController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
//tableView
@property(nonatomic, strong) UITableView *tableView;
//数据数组
@property(nonatomic, strong) NSMutableArray<LYRegisterItem *> *registerArr;

//存储tableView的所有NSIndexPath,以便在其他地方可以自由调取对应的cell
@property(nonatomic, strong) NSMutableArray *indexPathArr;
//下一步按钮
@property(nonatomic, strong) UIButton *continueBtn;
//提示label
@property(nonatomic, strong) UILabel *infoLabel;
//左边点击视图
@property(nonatomic, strong) UIView *leftTapView;
//原支付宝账号
@property(nonatomic, strong) NSString *aliAccount;

@end

static NSString *const LYFillDataCellID = @"LYFillDataCell";

@implementation LYAliccountController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 30, ScreenW, 300);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYFillDataCell class] forCellReuseIdentifier:LYFillDataCellID];
        
        _leftTapView = [[UIView alloc] init];
        _leftTapView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_leftTapView addGestureRecognizer:tap];
        _leftTapView.frame = CGRectMake(0, 30, 90, 300);
        [self.view addSubview:_leftTapView];
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
    [self getOrgialAliAccount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 239, 245);
    self.title = @"更换支付宝账号";
    self.tableView.backgroundColor = RGB(240, 239, 245);
    [self setUpData];
    [self setUpTopAndBottom];
}

#pragma mark - 下一步按钮
-(void)setUpTopAndBottom
{
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    _infoLabel.backgroundColor = RGB(246, 244, 216);
    _infoLabel.textColor = RGB(146, 145, 139);
    _infoLabel.font = PFR13Font;
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.text = @"请完善以下注册信息，务必保证商家信息真实";
    [self.view addSubview:_infoLabel];
    
    
    _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _continueBtn.backgroundColor = RGBA(50, 112, 229, 1.0);
    _continueBtn.layer.cornerRadius = 20.0;
    _continueBtn.layer.masksToBounds = YES;
    [_continueBtn setTitle:@"立即提交" forState:0];
    _continueBtn.titleLabel.font = PFR18Font;
    [self.view addSubview:_continueBtn];
    [_continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(420 - 15 + 40 - 135 + 45);
        make.height.equalTo(45);
    }];
    
}

#pragma mark - 资料界面数据
-(void)setUpData
{
    _registerArr = [LYRegisterItem mj_objectArrayWithFilename:@"AliData.plist"];
}

#pragma mark - 获取原支付宝账号
-(void)getOrgialAliAccount
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:userid forKey:@"agentid"];
    NSLog(@"%@", dic);
    __weak typeof(self) weakSelf= self;
    [AFOwnerHTTPSessionManager getAddToken:Getalipayaccount Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            _aliAccount = responseObject[@"Data"][@"alipayaccount"];
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 2 : (section == 2) ? 2 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYFillDataCell *cell = [tableView dequeueReusableCellWithIdentifier:LYFillDataCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.delegate = self;
    //    if (indexPath.row == 1 || indexPath.row == 2)
    //    {
    //
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //        cell.registerItem = _registerArr[indexPath.row];
    //    }
    //    else
    //    {
    cell.flag = YES;
    if (indexPath.section == 0)
    {
        cell.registerItem = _registerArr[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        cell.registerItem = _registerArr[indexPath.row + 2];
    }
    else if (indexPath.section == 2)
    {
        cell.registerItem = _registerArr[indexPath.row + 4];
        if (indexPath.row == 0)
        {
            cell.textField.text = _aliAccount;
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        cell.textField.secureTextEntry = YES;
    }
    
    //    }
    
    [self.indexPathArr addObject:indexPath];
    
    //    if (indexPath.row == 0)
    //    {
    //        _registerCell = cell;
    //    }
    
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
    footerView.backgroundColor = RGB(240, 239, 245);
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


#pragma mark - 点击事件

-(void)continueBtnClick
{
    NSLog(@"点击了下一步");
    LYFillDataCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    LYFillDataCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    LYFillDataCell *cellThree = [self.tableView cellForRowAtIndexPath:self.indexPathArr[2]];
    LYFillDataCell *cellFour = [self.tableView cellForRowAtIndexPath:self.indexPathArr[3]];
    LYFillDataCell *cellFive = [self.tableView cellForRowAtIndexPath:self.indexPathArr[4]];
    LYFillDataCell *cellSix = [self.tableView cellForRowAtIndexPath:self.indexPathArr[5]];
    NSLog(@"%@", cellOne.textField.text);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"publicKeyClient"];
    
    if (![DCSpeedy isBlankString:cellOne.textField.text] && ![DCSpeedy isBlankString:cellTwo.textField.text] && ![DCSpeedy isBlankString:cellThree.textField.text] && ![DCSpeedy isBlankString:cellFour.textField.text] && ![DCSpeedy isBlankString:cellFive.textField.text] && ![DCSpeedy isBlankString:cellSix.textField.text])
    {
        
        if (cellTwo.textField.text.length == 18)
        {
            if ([DCSpeedy isCorrect:cellTwo.textField.text])
            {
                if ([DCSpeedy valiMobile:cellThree.textField.text])
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
                    
                    NSString *publicKey1 = [RSAEncryptor encryptString:cellOne.textField.text publicKey:str];
                    NSString *publicKey2 = [RSAEncryptor encryptString:cellTwo.textField.text publicKey:str];
                    NSString *publicKey3 = [RSAEncryptor encryptString:cellThree.textField.text publicKey:str];
                    NSString *publicKey4 = [RSAEncryptor encryptString:cellFour.textField.text publicKey:str];
                    NSString *publicKey5 = [RSAEncryptor encryptString:cellFive.textField.text publicKey:str];
                    NSString *publicKey6 = [RSAEncryptor encryptString:cellSix.textField.text publicKey:str];
                    NSDictionary *dic = @{
                                          @"agentid": userid,
                                          @"NewName" : publicKey1,
                                          @"CretNo" : publicKey2,
                                          @"Phone" : publicKey3,
                                          @"Pwd" : publicKey4,
                                          @"OldAlipayAccount" : publicKey5,
                                          @"AlipayAccount" : publicKey6
                                          };
                
                    [AFOwnerHTTPSessionManager postAddToken:AddChangeAlipy Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"%@", responseObject);
                        NSString *code = responseObject[@"code"];
                        if ([code isEqualToString:@"0000"])
                        {
                            NSString *result = responseObject[@"Data"][@"success"];
                            if ([result floatValue] == 1)
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [hud hideAnimated:YES];
                                    [DCSpeedy alertMes:@"提交成功"];
                                });
                            }
                            else
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [hud hideAnimated:YES];
                                    [DCSpeedy alertMes:@"提交失败"];
                                });
                            }
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
                else
                {
                    [DCSpeedy alertMes:@"请输入正确的手机号"];
                }
            }
            else
            {
                [DCSpeedy alertMes:@"请输入合法的身份证号"];
            }
        }
        else
        {
            [DCSpeedy alertMes:@"身份证号码不满18位"];
        }
        
    }
    else
    {
        [DCSpeedy alertMes:@"请您完善具体信息"];
    }
    
}


#pragma mark - - shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    //UITextField 限制用户输入小数点后位数的方法
//    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
//    [futureString  insertString:string atIndex:range.location];
//    
//    NSInteger flag=0;
//    const NSInteger limited = 1;//小数点后一位
//    for (int i = (int)(futureString.length-1); i>=0; i--) {
//        
//        if ([futureString characterAtIndex:i] == '.') {
//            
//            if (flag > limited) {
//                return NO;
//            }
//            
//            break;
//        }
//        flag++;
//    }
//    
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 必须辞去第一响应者后,键盘才会回缩.
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
