//
//  LYShareViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYShareViewController.h"
// Controllers
#import "LYShareQrcodeController.h"
#import "LYShareFriendController.h"
#import "LYShareRegisterController.h"
#import "LYShareFaceController.h"
#import "LYShareVideoController.h"
#import "LYWalletServiceController.h"
// Models
#import "LYShareItem.h"
// Views
#import "LYShareItemCell.h"
#import "LYShareSocialCell.h"
// Vendors
#import <MJExtension.h>
#import "OpenShareHeader.h"
#import "BRPickerView.h"
// Categories

// Others

@interface LYShareViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYShareItem *> *messageArr;
//当前费率
@property(nonatomic, strong) NSString *currentRate;
//最大费率
@property(nonatomic, strong) NSString *maxRate;
//最小费率
@property(nonatomic, strong) NSString *minRate;
//间隔
@property(nonatomic, strong) NSString *interval;


@end

static NSString *const LYShareItemCellID = @"LYShareItemCell";
static NSString *const LYShareSocialCellID = @"LYShareSocialCell";

@implementation LYShareViewController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64 - 49);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYShareItemCell class] forCellReuseIdentifier:LYShareItemCellID];
        [_tableView registerClass:[LYShareSocialCell class] forCellReuseIdentifier:LYShareSocialCellID];
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    if (str)
    {
        [self setUpGetRate];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self setUpNav];
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text = @"推广赚钱";
    label.font = PFR20Font;
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
}

#pragma mark - 获取当前代理商费率
-(void)setUpGetRate
{
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:userid forKey:@"agentid"];
//    [AFOwnerHTTPSessionManager getAddToken:AgentRate Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        NSString *code = responseObject[@"code"];
//        if ([code isEqualToString:@"0000"])
//        {
//            NSString *rate = responseObject[@"Data"][@"AgentRate"];
//            NSString *str = [NSString stringWithFormat:@"%lf", [rate doubleValue] * 100];
//            NSString *fl = [DCSpeedy changeFloat:str];
//            _currentRate = fl;
//            NSLog(@"%@", _currentRate);
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//
//    }];
    
    [AFOwnerHTTPSessionManager getAddToken:GETChildAgentArea Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            _maxRate = responseObject[@"Data"][@"max"];
            _minRate = responseObject[@"Data"][@"min"];
            _interval = responseObject[@"Data"][@"interval"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
    
    
}

#pragma mark - 消息数据
-(void)setUpData
{
    _messageArr = [LYShareItem mj_objectArrayWithFilename:@"ShareNote.plist"];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *gridCell = nil;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 2)
    {
        LYShareSocialCell *cell = [tableView dequeueReusableCellWithIdentifier:LYShareSocialCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.weichatBtnClickBlock = ^{
            NSLog(@"点击了微信");
            [weakSelf setUpWeichat];
        };
        cell.friendBtnClickBlock = ^{
            NSLog(@"点击了朋友圈");
            [weakSelf setUpFriend];
        };
        cell.QQBtnClickBlock = ^{
            NSLog(@"点击了QQ");
            [weakSelf setUpQQ];
        };
        gridCell = cell;
    }
    else
    {
        LYShareItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYShareItemCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageItem = _messageArr[indexPath.row];
        gridCell = cell;
    }
    
    return gridCell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 2) ? 160 : 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        LYWalletServiceController *serVC = [[LYWalletServiceController alloc] init];
        serVC.title = @"宣传图文";
        serVC.urlString = @"http://www.1shouyin.com/AboutUs/tgcopy.html";
        [self.navigationController pushViewController:serVC animated:YES];
    }
    else if (indexPath.row == 0)
    {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
        if (str)
        {
            [self setUpChooseRate];
        }
        else
        {
            [DCSpeedy alertMes:@"请您先登录哦"];
        }
        
    }

}

-(void)setUpChooseRate
{
    NSMutableArray *mutableRate = [NSMutableArray arrayWithCapacity:1];
//    double rate = [_currentRate doubleValue];
    
    for (double i = [_minRate doubleValue] * 100 + [_interval doubleValue]; i <= [_maxRate doubleValue] * 100; i = i + [_interval doubleValue])
    {
        NSString *pp = [NSString stringWithFormat:@"%lf", i];
        NSString *str = [DCSpeedy changeFloat:pp];
        NSLog(@"%@", str);
        [mutableRate addObject:str];
    }
    
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"选择费率" dataSource:mutableRate defaultSelValue:mutableRate[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        NSLog(@"%@", selectValue);
        LYShareFriendController *friendVC = [[LYShareFriendController alloc] init];
        friendVC.rateStr = selectValue;
        [weakSelf.navigationController pushViewController:friendVC animated:YES];
    }];
    
}

#pragma mark - 分享
-(void)setUpWeichat
{
    //分享纯文本消息到微信会话，其他类型可以参考示例代码
    OSMessage *msg=[[OSMessage alloc]init];
    msg.title=@"喜鹊钱包下载中心";
    //link
    msg.link=@"http://f.chuandu365.com";
    msg.image = [UIImage imageNamed:@"ok"];//新闻类型的职能传缩略图就够了。
    [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
        NSLog(@"微信分享到会话成功：\n%@",message);
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
    }];
}

-(void)setUpFriend
{
    //分享纯文本消息到微信朋友圈，其他类型可以参考示例代码
    OSMessage *msg=[[OSMessage alloc] init];
    msg.title=@"喜鹊钱包下载中心";
    //link
    msg.link=@"http://f.chuandu365.com";
    msg.image = [UIImage imageNamed:@"ok"];//新闻类型的职能传缩略图就够了。
    [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
        NSLog(@"微信分享到朋友圈成功：\n%@",message);
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
    }];
}

-(void)setUpQQ
{
    //分享纯文本消息到QQ会话，其他类型可以参考示例代码
    OSMessage *msg=[[OSMessage alloc] init];
    msg.title=@"http://f.chuandu365.com";
    [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
        NSLog(@"分享到QQ好友成功:%@",msg);
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"分享到QQ好友失败:%@\n%@",msg,error);
    }];
}

-(void)setUpQQZone
{
    //分享纯文本消息到QQ空间，其他类型可以参考示例代码
    OSMessage *msg=[[OSMessage alloc]init];
    msg.title=@"喜鹊钱包下载中心";
    //link
    msg.link=@"http://f.chuandu365.com";
    msg.image = [UIImage imageNamed:@"ok"];//新闻类型的职能传缩略图就够了。
    [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
        NSLog(@"分享到QQ空间成功:%@",msg);
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"分享到QQ空间失败:%@\n%@",msg,error);
    }];
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
