//
//  LYMyselfViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyselfViewController.h"
// Controllers
#import "LYNavigationController.h"
#import "LYPersonalViewController.h"
#import "LYRealNameController.h"
#import "LYBankCardController.h"
#import "LYMoreSettingController.h"
#import "LYRelationController.h"
#import "LYLoginViewController.h"
#import "LYAgentsController.h"
#import "LYWalletServiceController.h"
#import "LYWalletServiceController.h"
// Models
#import "LYMyselfItem.h"
// Views
#import "LYMyselfItemCell.h"
#import "LYMyselfHeader.h"
// Vendors
#import <MJExtension.h>
#import "WJYAlertView.h"
#import "DCSelPhotos.h"
#import "UIImage+DCCircle.h"
//相机类
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
// Categories

// Others

@interface LYMyselfViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) LYMyselfHeader *headerView;

@property(nonatomic, strong) NSMutableArray<LYMyselfItem *> *messageArr;

@property(nonatomic, strong) NSDictionary *property;
//相机
@property(nonatomic, strong) UIImagePickerController *imagePickerController;
//接收通知
@property(nonatomic, weak) id lyObsever;

@end

static NSString *const LYMyselfItemCellID = @"LYMyselfItemCell";

@implementation LYMyselfViewController

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 130, ScreenW, ScreenH - 120 - 60 - 49);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //修饰轮廓
//        _tableView.layer.cornerRadius = 8.0;
//        _tableView.layer.masksToBounds = YES;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerClass:[LYMyselfItemCell class] forCellReuseIdentifier:LYMyselfItemCellID];
    }
    return _tableView;
}

-(UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController)
    {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

-(LYMyselfHeader *)headerView
{
    if (!_headerView)
    {
        _headerView = [[LYMyselfHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
        __weak typeof(self) weakSelf = self;
        
        _headerView.bgClickBlock = ^{
            //检测是否登录过没
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
            if (str)
            {
                
            }
            else
            {
                [weakSelf rightLogin];
            }
        };
        
        _headerView.viewClickBlock = ^{
            
            
            
//            __weak typeof(self) weakSelf = self;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了相册");
                
                DCSelPhotos *imageManager = [DCSelPhotos selPhotos];
                [imageManager pushImagePickerControllerWithImagesCount:1 WithColumnNumber:4 didFinish:^(TZImagePickerController *imagePickerVc) {
                    
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf presentViewController:imagePickerVc animated:YES completion:nil];
                    
                    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                        
//                        weakSelf.headerView.titleImgView.image = photos.lastObject;
                        LYUserInfo *userInfo = UserInfoData;
                        if (![userInfo.userimage isEqualToString:[DCSpeedy UIImageToBase64Str:photos.lastObject]])
                        {
                            userInfo.userimage = [DCSpeedy UIImageToBase64Str:photos.lastObject];
                            [userInfo save];
                            UIImage *image = ([userInfo.userimage isEqualToString:@"头像"]) ? [UIImage imageNamed:@"头像"] : [DCSpeedy Base64StrToUIImage:userInfo.userimage];
                             [weakSelf.headerView.titleImgView setImage:image];
                        }
                       
                    }];
                    
                }];
                
            }]];
        
            [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了拍照");
              weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                //相机类型（拍照）字符串需要做相应的类型转换
//                weakSelf.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                //设置摄像头模式（拍照）为录像模式
//                weakSelf.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
                [weakSelf presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击取消");
            }]];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
            
        };
    }
    return _headerView;
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
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermerchant_name"];
    NSLog(@"%@", str1);
    
    if (str)
    {
        self.headerView.titleLabel.text = str1;
        self.headerView.infoLabel.text = str;
         [self.headerView.indicatorBtn setImage:[UIImage imageNamed:@"箭"] forState:UIControlStateNormal];
    }
    else
    {
        self.headerView.titleLabel.text = @"游客";
        self.headerView.infoLabel.text = @"马上登录";
         [self.headerView.indicatorBtn setImage:[UIImage imageNamed:@"箭头3"] forState:UIControlStateNormal];
        //这个是清空缓存之后刷新界面
        //这个是让它回到初始位置，进行刷新更新新的代理值，否则的话第一个隐藏的话，就会赋值第二个
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 0.01, 0.01) animated:YES];
        [self setUpData];
        [self.tableView reloadData];
    }
    
    if (str)
    {
        //这个是让它回到初始位置，进行刷新更新新的代理值，否则的话第一个隐藏的话，就会赋值第二个
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 0.01, 0.01) animated:YES];
        [self setUpData];
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
        NSDictionary *dic = @{
                              @"agentid": userid
                              };
        [AFOwnerHTTPSessionManager getAddToken:AgentRate Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            NSString *code = responseObject[@"code"];
            if ([code isEqualToString:@"0000"])
            {
                //小额
                NSString *rate = responseObject[@"Data"][@"AgentRate"];
                
                NSString *str = [NSString stringWithFormat:@"%lf", [rate doubleValue] * 100];
                NSString *f1 = [DCSpeedy changeFloat:str];
                
                //大额
                NSString *largeRate = responseObject[@"Data"][@"AgentRate_arge"];
                NSString *f2 = nil;
                if ([DCSpeedy isBlankString:largeRate])
                {
                    f2 = @"--";
                }
                else
                {
                    NSString *largeStr = [NSString stringWithFormat:@"%lf", [largeRate doubleValue] * 100];
                    f2 = [DCSpeedy changeFloat:largeStr];
                }
                
                //信用卡
                NSString *creditRate = responseObject[@"Data"][@"AgentRate_credit"];
                NSString *f3 = nil;
                if ([DCSpeedy isBlankString:largeRate])
                {
                    f3 = @"--";
                }
                else
                {
                    NSString *creditStr = [NSString stringWithFormat:@"%lf", [creditRate doubleValue] * 100];
                    f3 = [DCSpeedy changeFloat:creditStr];
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:f1 forKey:@"rate"];
                [[NSUserDefaults standardUserDefaults] setObject:f2 forKey:@"largeRate"];
                [[NSUserDefaults standardUserDefaults] setObject:f3 forKey:@"creditRate"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
            
        }];
    }
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
    // 这样设置状态栏样式是黑色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self acceptanceNote];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.headerView];
    
    self.tableView.backgroundColor = DCBGColor;
    
    [self setUpNav];
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"设置"] forState:0];
    button.frame = CGRectMake(0, 0, 28, 28);
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 消息数据
-(void)setUpData
{
    _messageArr = [LYMyselfItem mj_objectArrayWithFilename:@"MyselfNote.plist"];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYMyselfItemCell *cell = [tableView dequeueReusableCellWithIdentifier:LYMyselfItemCellID];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0)
    {
        cell.myselfItem = _messageArr[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        cell.myselfItem = _messageArr[indexPath.row + 1];
    }
    else if (indexPath.section == 2)
    {
        cell.myselfItem = _messageArr[indexPath.row + 3];
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
        if (str)
        {
            [self referencePeople];
        }
        else
        {
            [DCSpeedy alertMes:@"请您先登录"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        [self setUpAllAgents];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        [self myselfService];
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        LYWalletServiceController *relateUsVc = [[LYWalletServiceController alloc] init];
        relateUsVc.urlString = [NSString stringWithFormat:@"%@AboutUs/aboutus.html", Localhost];
//        relateUsVc.urlString = @"http://api.047104086014.gaofangh.com/AboutUs/aboutus.html";
        relateUsVc.title = @"关于我们";
        [self.navigationController pushViewController:relateUsVc animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
//        [self moreSetting];
        LYWalletServiceController *serVC = [[LYWalletServiceController alloc] init];
        serVC.title = @"常见问题";
        serVC.urlString = [NSString stringWithFormat:@"%@AboutUs/question.html", Localhost];
//        serVC.urlString = @"http://www.1shouyin.com/AboutUs/question.html";
        [self.navigationController pushViewController:serVC animated:YES];
    }
//    else if (indexPath.row == 4)
//    {
//        [self relationMine];
//    }
//    else if (indexPath.row == 5)
//    {
//        [self moreSetting];
//    }
//    else if (indexPath.row == 6)
//    {
//        [self registerOut];
//    }
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        LYUserInfo *userInfo = UserInfoData;
        userInfo.userimage = [DCSpeedy UIImageToBase64Str:info[UIImagePickerControllerEditedImage]];
        [userInfo save];
        UIImage *image = ([userInfo.userimage isEqualToString:@"头像2"]) ? [UIImage imageNamed:@"头像2"] : [DCSpeedy Base64StrToUIImage:userInfo.userimage];
        [self.headerView.titleImgView setImage:image];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 接收通知
-(void)acceptanceNote
{
    __weak typeof(self) weakSelf = self;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermerchant_name"];
    //修改登录状态
    _lyObsever = [[NSNotificationCenter defaultCenter] addObserverForName:@"fixMyselfHeader" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.headerView.titleLabel.text = str1;
        weakSelf.headerView.infoLabel.text = str;
    }];
}

#pragma mark - 立刻登录
-(void)rightLogin
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"我们还没有找到您的账户信息，请马上登录！" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 费率总括
-(void)referencePeople
{
    //小额
    NSString *rate = [[NSUserDefaults standardUserDefaults] objectForKey:@"rate"];
    NSString *rate1 = [NSString stringWithFormat:@"%@%@", rate, @"%"];
    NSString *xiaoRate = [NSString stringWithFormat:@"小额费率是:%@", rate1];
    //大额
    NSString *largeRate = [[NSUserDefaults standardUserDefaults] objectForKey:@"largeRate"];
    NSString *rate2 = [NSString stringWithFormat:@"%@%@", largeRate, @"%"];
    NSString *bigRate = [NSString stringWithFormat:@"大额费率是:%@", rate2];
    //信用卡
    NSString *creditRate = [[NSUserDefaults standardUserDefaults] objectForKey:@"creditRate"];
    NSString *rate3 = [NSString stringWithFormat:@"%@%@", creditRate, @"%"];
    NSString *xinRate = [NSString stringWithFormat:@"信用卡费率是:%@", rate3];
    
    NSString *message = [NSString stringWithFormat:@"%@\n%@\n%@", xiaoRate, bigRate, xinRate];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您的费率" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 获取所有的代理商
-(void)setUpAllAgents
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    if (str)
    {
        [self.navigationController pushViewController:[[LYAgentsController alloc] init] animated:YES];
    }
    else
    {
        [DCSpeedy alertMes:@"请您先登录"];
    }
}

#pragma mark - 实名认证
-(void)realName
{
    [self.navigationController pushViewController:[[LYRealNameController alloc] init] animated:YES];
}

#pragma mark -
-(void)bankCard
{
    [self.navigationController pushViewController:[[LYBankCardController alloc] init] animated:YES];
}

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

#pragma mark - 关于我们
-(void)relationMine
{
    [self.navigationController pushViewController:[[LYRelationController alloc] init] animated:YES];
}

#pragma mark - 更多设置
-(void)rightBarClick
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    if (str)
    {
        [self.navigationController pushViewController:[[LYMoreSettingController alloc] init] animated:YES];
    }
    else
    {
        [DCSpeedy alertMes:@"请您先登录"];
    }
    
}

#pragma mark - 退出登录
-(void)registerOut
{
//    __weak typeof(self) weakSelf = self;
    [WJYAlertView showTwoButtonsWithTitle:@"温馨提示" Message:@"是否要退出登录" ButtonType:WJYAlertViewButtonTypeWarn ButtonTitle:@"确定" Click:^{
        
//        [weakSelf.navigationController popViewControllerAnimated:YES];
        //标记登录状态
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } ButtonType:WJYAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
        NSLog(@"点击取消");
    }];
}


#pragma mark - 销毁观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_lyObsever];
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
