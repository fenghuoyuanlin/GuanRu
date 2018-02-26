//
//  LYServiceItemController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/23.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYServiceItemController.h"
// Controllers

// Models
#import "LYServiceItem.h"
// Views
#import "LYServiceItemCell.h"
#import "AppDelegate.h"
#import "LYCodeView.h"
// Vendors
#import <MJExtension.h>
#import <MJRefresh.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others

@interface LYServiceItemController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<LYServiceItem *> *messageArr;

//二维码
@property (nonatomic, strong) LYCodeView *codeview;

@end

static NSString *const LYServiceItemCellID = @"LYServiceItemCell";

@implementation LYServiceItemController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYServiceItemCell class] forCellReuseIdentifier:LYServiceItemCellID];
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    //    [self setUpNav];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = DCBGColor;
}

#pragma mark - 消息数据
-(void)setUpData
{
    _messageArr = [LYServiceItem mj_objectArrayWithFilename:@"ServiceItem.plist"];
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYServiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYServiceItemCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.serviceItem = _messageArr[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self shouWeixinImage];
    }
    else if (indexPath.row == 1)
    {
        [self copyWeixinhao];
    }
    else if (indexPath.row == 2)
    {
        [self myselfService];
    }
}


#pragma mark - 微信公众号图片
-(void)shouWeixinImage
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _codeview = [[LYCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    _codeview.img = [UIImage imageNamed:@"Weichat"];
    _codeview.titleLab.text = @"微信扫扫关注我们";
    UITapGestureRecognizer *clipTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCancelActivityAction:)];
    [self.codeview addGestureRecognizer:clipTap];
    [delegate.window addSubview:_codeview];
    _codeview.codeImage.image = [UIImage imageNamed:@"Weichat"];
}

//点击取消按钮
- (void)didCancelActivityAction:(UIGestureRecognizer *)tap {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.codeview.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.codeview.hidden = YES;
        }
    }];
    //做图片放大的效果
//    [UIView beginAnimations:@"Animations_4" context:nil];
//    [UIView setAnimationDuration:1];
//    self.codeview.transform = CGAffineTransformScale(self.codeview.transform, 3, 3);
//    [UIView commitAnimations];
    
}

#pragma mark - 复制微信公众号
-(void)copyWeixinhao
{
    NSArray *arr = @[@"pppppooooo11128", @"pppppooooo11124", @"pppppooooo11116"];
    int x = arc4random() % 3;
    NSLog(@"%d", x);
    NSString *str = nil;
    if (x == 0)
    {
        str = arr[0];
    }
    else if (x == 1)
    {
        str = arr[1];
    }
    else if (x == 2)
    {
        str = arr[2];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"客服微信号" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确认");
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = str;
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 客服电话
#pragma mark - 我的客服
-(void)myselfService
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"客服时间:9:00-17:30\n0571-28827446" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        NSString *str = @"tel://0571-28827446";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
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
