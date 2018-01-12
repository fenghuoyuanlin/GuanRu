//
//  LYFaceShareController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/8.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYFaceShareController.h"
// Controllers

// Models

// Views
#import "LYUIBLButton.h"
// Vendors
#import "UIViewController+XWTransition.h"
#import "OpenShareHeader.h"
// Categories

// Others

@interface LYFaceShareController ()

//标题
@property(nonatomic, strong) UILabel *titleLabel;
//分享按钮
@property(nonatomic, strong) LYUIBLButton *weichatBtn;

@property(nonatomic, strong) LYUIBLButton *friendBtn;

@property(nonatomic, strong) LYUIBLButton *qqBtn;

@end

@implementation LYFaceShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpShareAlterView];
    [self setUpBase];
}

-(void)setUpBase
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    _titleLabel.text = @"立即分享";
    [self.view addSubview:_titleLabel];
    
    _weichatBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_weichatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [_weichatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_weichatBtn setTitle:@"微信" forState:0];
    _weichatBtn.titleLabel.font = PFR16Font;
    _weichatBtn.tag = 0;
    [self.view addSubview:_weichatBtn];
    
    [_weichatBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _friendBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_friendBtn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    [_friendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_friendBtn setTitle:@"朋友圈" forState:0];
    _friendBtn.titleLabel.font = PFR16Font;
    _friendBtn.tag = 1;
    [self.view addSubview:_friendBtn];
    
    [_friendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _qqBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [_qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_qqBtn setTitle:@"QQ" forState:0];
    _qqBtn.titleLabel.font = PFR16Font;
    _qqBtn.tag = 2;
    [self.view addSubview:_qqBtn];
    
    [_qqBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(DCMargin);
    }];
    
    
    [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(20);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [_weichatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_friendBtn.left).offset(-self.view.dc_width / 6);
        make.centerY.equalTo(_friendBtn.centerY);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_friendBtn.right).offset(self.view.dc_width / 6);
        make.centerY.equalTo(_friendBtn.centerY);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
}

#pragma mark - 点击事件
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [self setUpWeichat];
    }
    else if (sender.tag == 1)
    {
        [self setUpFriend];
    }
    else if (sender.tag == 2)
    {
        [self setUpQQ];
    }
}


#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}

#pragma mark - 点击事件
-(void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 分享
-(void)setUpWeichat
{
    //分享纯文本消息到微信会话，其他类型可以参考示例代码
    OSMessage *msg=[[OSMessage alloc]init];
    msg.title = @"msg";
    msg.image = _img;
//    msg.thumbnail = _img;
    NSLog(@"%@", _img);
    msg.desc=[NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];
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
    msg.title = @"msg";
    msg.image = _img;
//    msg.thumbnail = _img;
    NSLog(@"%@", _img);
    msg.desc=[NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];
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
    msg.title = @"msg";
    msg.image = _img;
    msg.thumbnail = _img;
    NSLog(@"%@", _img);
    msg.desc=[NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];
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
