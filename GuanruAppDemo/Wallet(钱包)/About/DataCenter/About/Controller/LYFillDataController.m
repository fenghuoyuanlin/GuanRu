//
//  LYFillDataController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/21.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYFillDataController.h"
// Controllers
#import "LYQrcodeController.h"
// Models
#import "LYRegisterItem.h"
// Views
#import "LYFillDataCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface LYFillDataController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

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

@end

static NSString *const LYFillDataCellID = @"LYFillDataCell";

@implementation LYFillDataController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 30, ScreenW, 420);
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
        _leftTapView.frame = CGRectMake(0, 30, 90, 420);
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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 239, 245);
    self.title = @"大额收款";
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
        make.top.equalTo(420 - 15 + 40);
        make.height.equalTo(45);
    }];
    
}

#pragma mark - 资料界面数据
-(void)setUpData
{
    _registerArr = [LYRegisterItem mj_objectArrayWithFilename:@"FillData.plist"];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 3 : (section == 3 || section == 1) ? 2 : 1;
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
        cell.registerItem = _registerArr[indexPath.row + 3];
    }
    else if (indexPath.section == 2)
    {
        cell.registerItem = _registerArr[indexPath.row + 5];
    }
    else if (indexPath.section == 3)
    {
        cell.registerItem = _registerArr[indexPath.row + 6];
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
    footerView.backgroundColor = DCBGColor;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


#pragma mark - 点击事件

-(void)verCodeBtnClick
{
    NSLog(@"点击了验证码");
    LYFillDataCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    NSLog(@"%@", cell.textField.text);
}

-(void)continueBtnClick
{
    NSLog(@"点击了下一步");
    LYFillDataCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[0]];
    LYFillDataCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    LYFillDataCell *cellThree = [self.tableView cellForRowAtIndexPath:self.indexPathArr[2]];
    LYFillDataCell *cellFour = [self.tableView cellForRowAtIndexPath:self.indexPathArr[3]];
    LYFillDataCell *cellFive = [self.tableView cellForRowAtIndexPath:self.indexPathArr[4]];
    LYFillDataCell *cellSix = [self.tableView cellForRowAtIndexPath:self.indexPathArr[5]];
    LYFillDataCell *cellSeven = [self.tableView cellForRowAtIndexPath:self.indexPathArr[6]];
    LYFillDataCell *cellEight = [self.tableView cellForRowAtIndexPath:self.indexPathArr[7]];
    NSLog(@"%@", cellOne.textField.text);
    
    if (![DCSpeedy isBlankString:cellOne.textField.text] && ![DCSpeedy isBlankString:cellTwo.textField.text] && ![DCSpeedy isBlankString:cellThree.textField.text] && ![DCSpeedy isBlankString:cellFour.textField.text] && ![DCSpeedy isBlankString:cellFive.textField.text] && ![DCSpeedy isBlankString:cellSix.textField.text] && ![DCSpeedy isBlankString:cellSeven.textField.text] && ![DCSpeedy isBlankString:cellEight.textField.text])
    {
        
        if ([cellFour.textField.text doubleValue] > 1.2)
        {
            [DCSpeedy alertMes:@"输入数值不能大于1.2"];
        }
        else if ([cellFive.textField.text doubleValue] < [cellFour.textField.text doubleValue])
        {
            double merrate = [cellFour.textField.text doubleValue] * 0.01;
            double lerate = [cellFive.textField.text doubleValue] * 0.01;
            int lowerLimit = [cellSix.textField.text intValue];
            int upperLimit = [cellSeven.textField.text intValue];
            int limitAmount = [cellEight.textField.text intValue];
            NSString *timestamp = [DCSpeedy getNowTimeTimestamp];
            NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
            NSDictionary *dic = @{
                                  @"agentid": userid,
                                  @"merchantName" : cellOne.textField.text,
                                  @"mediationName" : cellTwo.textField.text,
                                  @"alipayaAccount" : cellThree.textField.text,
                                  @"merrate" : @(merrate),
                                  @"Levelrate" : @(lerate),
                                  @"lowerLimit" : @(lowerLimit),
                                  @"upperLimit" : @(upperLimit),
                                  @"limitAmount" : @(limitAmount),
                                  @"creattime" : timestamp,
                                  @"surplusamount" : @(0),
                                  @"accountratetype" : @(1),
                                  @"partnerID" : @"0",
                                  @"status" : @(0)
                                  };
            NSLog(@"%@", dic);
            __weak typeof(self) weakSelf = self;
            [AFOwnerHTTPSessionManager postAddToken:AddMerInfoRate Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@", responseObject);
                NSString *str = responseObject[@"code"];
                if ([str isEqualToString:@"0000"])
                {
                    NSString *str = responseObject[@"Data"][@"url"];
                    NSLog(@"%@", str);
                    [DCSpeedy alertMes:@"提交成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        LYQrcodeController *QRvc = [[LYQrcodeController alloc] init];
                        QRvc.codeStr = str;
                        QRvc.storeStr = cellOne.textField.text;
                        [weakSelf.navigationController pushViewController:QRvc animated:YES];
                    });
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
                
            }];
        }
        else
        {
            [DCSpeedy alertMes:@"分润费率小于供码费率"];
        }
       
    }
    else
    {
        [DCSpeedy alertMes:@"请您完善具体信息"];
    }
    
}


#pragma mark - - shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //UITextField 限制用户输入小数点后位数的方法
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = 1;//小数点后一位
    for (int i = (int)(futureString.length-1); i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }
    
    return YES;
}

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
