//
//  LYChangePasswordController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/24.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYChangePasswordController.h"
// Controllers

// Models
#import "LYRegisterItem.h"
// Views
#import "LYChangePassCell.h"
// Vendors
#import <MJExtension.h>
#import "RSAEncryptor.h"
// Categories

// Others

@interface LYChangePasswordController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
//tableView
@property(nonatomic, strong) UITableView *tableView;
//数据数组
@property(nonatomic, strong) NSMutableArray<LYRegisterItem *> *registerArr;

//存储tableView的所有NSIndexPath,以便在其他地方可以自由调取对应的cell
@property(nonatomic, strong) NSMutableArray *indexPathArr;
//提交按钮
@property(nonatomic, strong) UIButton *continueBtn;

@end

static NSString *const LYChangePassCellID = @"LYChangePassCell";

@implementation LYChangePasswordController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 20, ScreenW, 420);
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYChangePassCell class] forCellReuseIdentifier:LYChangePassCellID];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 239, 245);
    self.title = @"修改密码";
    self.tableView.backgroundColor = RGB(240, 239, 245);
    [self setUpData];
    [self setUpTopAndBottom];
}

#pragma mark - 下一步按钮
-(void)setUpTopAndBottom
{
    
    _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _continueBtn.backgroundColor = RGBA(50, 112, 229, 1.0);
    _continueBtn.layer.cornerRadius = 20.0;
    _continueBtn.layer.masksToBounds = YES;
    [_continueBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:_continueBtn];
    
    [_continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(240);
        make.height.equalTo(50);
    }];
    
}

#pragma mark - 资料界面数据
-(void)setUpData
{
    _registerArr = [LYRegisterItem mj_objectArrayWithFilename:@"ChangePass.plist"];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LYChangePassCell *cell = [tableView dequeueReusableCellWithIdentifier:LYChangePassCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.delegate = self;
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell.registerItem = _registerArr[0];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.registerItem = _registerArr[1];
        cell.textField.secureTextEntry = YES;
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        cell.registerItem = _registerArr[2];
        cell.textField.secureTextEntry = YES;
    }
    [self.indexPathArr addObject:indexPath];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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


#pragma mark - 点击事件

-(void)continueBtnClick
{
    NSLog(@"点击了提交");
    LYChangePassCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    LYChangePassCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    LYChangePassCell *cellThree = [self.tableView cellForRowAtIndexPath:self.indexPathArr[2]];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"publicKeyClient"];
    NSLog(@"%@", str);
    NSLog(@"%@", cellThree.textField.text);
    if (![DCSpeedy isBlankString:cellOne.textField.text] && ![DCSpeedy isBlankString:cellTwo.textField.text] && ![DCSpeedy isBlankString:cellThree.textField.text])
    {
        if ([cellTwo.textField.text isEqualToString:cellThree.textField.text])
        {
            if (cellTwo.textField.text.length >= 6)
            {
                NSString *publicKey1 = [RSAEncryptor encryptString:cellOne.textField.text publicKey:str];
                NSString *publicKey2 = [RSAEncryptor encryptString:cellTwo.textField.text publicKey:str];
                NSLog(@"%@", publicKey2);
                
                NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
                NSDictionary *dic = @{
                                      @"agentid": userid,
                                      @"OldPwd" : publicKey1,
                                      @"NewPwd" : publicKey2,
                                      @"cfigPwd" : publicKey2
                                      };
                __weak typeof(self) weakSelf = self;
                [AFOwnerHTTPSessionManager postAddToken:UpdatePwd Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@", responseObject);
                    NSString *str = responseObject[@"code"];
                    if ([str isEqualToString:@"0000"])
                    {
                        [DCSpeedy alertMes:@"修改成功"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        });
                    }
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@", error);
                    
                }];
            }
            else
            {
                [DCSpeedy alertMes:@"密码至少为6位"];
            }
        }
        else
        {
            [DCSpeedy alertMes:@"新密码两次输入不相等"];
        }
    }
    else
    {
        [DCSpeedy alertMes:@"请完善所有信息"];
    }
    
    
    
}

#pragma mark - - shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制输入的内容只能为数字和字母
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
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
