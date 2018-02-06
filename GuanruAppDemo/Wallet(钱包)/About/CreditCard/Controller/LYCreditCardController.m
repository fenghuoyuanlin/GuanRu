//
//  LYCreditCardController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYCreditCardController.h"
// Controllers

// Models

// Views
#import "LYFacePayCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface LYCreditCardController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

//tableView
@property(nonatomic, strong) UITableView *tableView;
//存储tableView的所有NSIndexPath,以便在其他地方可以自由调取对应的cell
@property(nonatomic, strong) NSMutableArray *indexPathArr;
//下一步按钮
@property(nonatomic, strong) UIButton *continueBtn;

@end

static NSString *const LYFacePayCellID = @"LYFacePayCell";

@implementation LYCreditCardController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, 120);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        //        _tableView.tableFooterView = [UIView new];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYFacePayCell class] forCellReuseIdentifier:LYFacePayCellID];
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
    self.title = @"新增链接";
    self.tableView.backgroundColor = RGB(240, 239, 245);
    [self setUpTopAndBottom];
    
}

#pragma mark - 下一步按钮
-(void)setUpTopAndBottom
{
    
    _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _continueBtn.backgroundColor = RGBA(50, 112, 229, 1.0);
    _continueBtn.layer.cornerRadius = 20.0;
    _continueBtn.layer.masksToBounds = YES;
    [_continueBtn setTitle:@"+确认添加" forState:0];
    _continueBtn.titleLabel.font = PFR18Font;
    [self.view addSubview:_continueBtn];
    [_continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(120 + 30);
        make.height.equalTo(45);
    }];
    
}

#pragma mark - 资料界面数据

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYFacePayCell *cell = [tableView dequeueReusableCellWithIdentifier:LYFacePayCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2)
    {
        cell.textField.delegate = self;
    }
    if (indexPath.row == 0)
    {
        cell.flag = YES;
        
    }
    else
    {
        cell.flag = NO;
        NSArray *titles = @[@"店名:", @"点位:"];
        cell.titleLabel.text = titles[indexPath.row - 1];
        if (indexPath.row == 2)
        {
            cell.textField.placeholder = @"小于25个点且为0.5的整数倍";
        }
        
    }
    
    [self.indexPathArr addObject:indexPath];
    
    //    if (indexPath.row == 0)
    //    {
    //        _registerCell = cell;
    //    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


#pragma mark - 点击事件

-(void)continueBtnClick
{
    NSLog(@"点击了下一步");
    
    LYFacePayCell *cellOne = [self.tableView cellForRowAtIndexPath:self.indexPathArr[1]];
    NSLog(@"%@", cellOne.textField.text);
    LYFacePayCell *cellTwo = [self.tableView cellForRowAtIndexPath:self.indexPathArr[2]];
    NSLog(@"%@", cellTwo.textField.text);
    if (![DCSpeedy isBlankString:cellOne.textField.text] && ![DCSpeedy isBlankString:cellTwo.textField.text])
    {
        if ([cellTwo.textField.text doubleValue] > 25)
        {
            [DCSpeedy alertMes:@"输入的点数小于等于25"];
        }
        else if (fmod([cellTwo.textField.text doubleValue],0.5) == 0)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [DCSpeedy alertMes:@"亲暂无权限"];
            });
        }
        else
        {
            [DCSpeedy alertMes:@"请输入0.5的倍数"];
        }
        
        
    }
    else
    {
        [DCSpeedy alertMes:@"请输入店名或点数"];
    }
    
    
    
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
