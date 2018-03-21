//
//  AppDelegate.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "AppDelegate.h"
#import "LYTabbarController.h"
#import "LYGuidePageController.h"
#import "LYUserInfo.h"
#import "LYForceUpdateView.h"
#import "OpenShareHeader.h"
#import "LYWalletServiceController.h"
#import "LYNavigationController.h"
#import "LYSkipViewController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate, UNUserNotificationCenterDelegate>

@property(nonatomic, strong) LYTabbarController *tabbarController;

@property (nonatomic, strong) LYForceUpdateView *view;//强更视图

@property(nonatomic, strong) NSString *appleId;
//通知的内容以及格式
@property (nonatomic, strong) UNMutableNotificationContent *notiContent;

@end

#define appJPushKey @"5260a998d2a094abbc921cfc"
#define isProduction YES

@implementation AppDelegate

#pragma mark - 懒加载
-(LYTabbarController *)tabbarController
{
    if (!_tabbarController)
    {
        _tabbarController = [[LYTabbarController alloc] init];
    }
    return _tabbarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //FMDB数据缓存本地
    [self setUpUserData];
    
    //判断是否第一次进入app
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLogin"])
    {
        self.window.rootViewController = self.tabbarController;
    }
    else
    {
        LYGuidePageController *guideVC = [[LYGuidePageController alloc] init];
        self.window.rootViewController = guideVC;
    }
    
    //版本更新检测
    [self appUpDate];
    
    //极光推送
    [self JpushnoticationWithLanchOptions:launchOptions];
    //自定义消息
//    [self zdyNoticaton];
    
    //添加本地通知
    //如果已经获得发送通知哦的授权则创建本地通知，否则请求授权（注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置）
    //iOS10.0后需要设置一下通知的类型
    //注册通知
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
//    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            NSLog(@"request authorization successed!");
//        }
//    }];
//    //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。
//    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//        NSLog(@"%@",settings);
//    }];
//
//    self.notiContent = [[UNMutableNotificationContent alloc] init];
//    //引入代理
//    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];

    
    //openshanre分享
    [self setUpShare];
    
    return YES;
}

#pragma mark - 极光推送
-(void)JpushnoticationWithLanchOptions:(NSDictionary *)launchOptions
{
    //极光推送
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appJPushKey
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    ////2.1.9版本新增获取registration id block接口
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
    
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate
//前台得到的的通知对象
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //你要处理的逻辑
//        self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:1];
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
            //最后把Iconbadge归0
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
//后台得到的的通知对象(当用户点击通知栏的时候)
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //你要处理的逻辑
//        self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:1];
        NSString *selectedId = [NSString stringWithFormat:@"%@", userInfo[@"id"]];
        NSString *noticeType = [NSString stringWithFormat:@"%@", userInfo[@"noticeType"]];
        
        if ([noticeType isEqualToString:@"1"])
        {
            self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:1];
        }
        else if ([noticeType isEqualToString:@"2"])
        {
            
        }
        else if ([noticeType isEqualToString:@"3"])
        {
            self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:2];
        }
        else if ([noticeType isEqualToString:@"4"])
        {
            
        }
        else if ([noticeType isEqualToString:@"5"])
        {
            
        }
        else if ([noticeType isEqualToString:@"6"])
        {
            
        }
        else if ([noticeType isEqualToString:@"7"])
        {
            
        }
        else if ([noticeType isEqualToString:@"8"])
        {
            
        }
        else if ([noticeType isEqualToString:@"9"])
        {
            [self getMoreDetailContentWithId:selectedId];
        }
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
            //最后把Iconbadge归0
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        NSLog(@"iOS10 收到远程通知:%@",userInfo);

    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"%@", userInfo);
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 自定义消息回调
-(void)zdyNoticaton
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSLog(@"%@", userInfo);
    NSDictionary *dic = [DCSpeedy dictionaryWithJsonString:content];
    NSLog(@"%@", dic);
//    [self addLocalNotificationWithIntroduction:dic];
    NSLog(@"%@", dic[@"data"][@"noticeImgUrl"]);
    if ([DCSpeedy isBlankString:dic[@"data"][@"noticeImgUrl"]])
    {
        [self addNormalNotication:dic];
    }
    else
    {
        [self addImagesNotification:dic];
    }
    
}

#pragma mark - 添加本地通知

//添加本地通知
- (void)regiterLocalNotification:(UNMutableNotificationContent *)content AndMessage:(NSDictionary *)dic
{
    //这里用来跳转相应的界面
    NSString *type = [NSString stringWithFormat:@"%@", dic[@"type"]];
    content.launchImageName = type;
    NSString *noticeType = [NSString stringWithFormat:@"%@", dic[@"data"][@"noticeType"]];
    content.threadIdentifier = noticeType;
    content.subtitle = dic[@"data"][@"noticeTitle"];
    content.body = dic[@"data"][@"noticeIntroduction"];
    content.badge = @1;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
    content.sound = sound;
    
    content.categoryIdentifier = [NSString stringWithFormat:@"%@", dic[@"data"][@"id"]];
    //重复提醒，时间间隔要大于60s
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1.0 repeats:NO];
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error.localizedDescription);
    }];
    
}

// 普通通知
- (void)addNormalNotication:(NSDictionary *)sender {
    
    [self regiterLocalNotification:self.notiContent AndMessage:sender];
    
}

// 图片通知
- (void)addImagesNotification:(NSDictionary *)sender {
    
    NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"4" ofType:@"png"];
    
//    NSURL *url = [NSURL URLWithString:@"https://t10.baidu.com/it/u=945743694,2349604750&fm=173&s=9B9D6C855C12D1C61C00859803001097&w=640&h=356&img.JPEG"];
    
    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"iamgeAttachment" URL:[NSURL fileURLWithPath:imageFile] options:nil error:nil];
    self.notiContent.attachments = @[imageAttachment];
    
    [self regiterLocalNotification:self.notiContent AndMessage:sender];
}
// 视频通知
- (void)addVideoNotification:(NSDictionary *)sender {
    
    NSString *videoFile = [[NSBundle mainBundle] pathForResource:@"视频名字" ofType:@"格式"];
    
    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"iamgeAttachment" URL:[NSURL fileURLWithPath:videoFile] options:nil error:nil];
    self.notiContent.attachments = @[imageAttachment];
    
    [self regiterLocalNotification:self.notiContent AndMessage:sender];
}

#pragma mark - **************** 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - 点击本地通知代理方法（应用在前台或后台，未被杀死时）
#pragma mark - delegate
//只有当前处于前台才会走，加上返回方法，使在前台显示信息
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"执行willPresentNotificaiton");
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    NSString *subTitle = response.notification.request.content.subtitle;
    NSString *type = response.notification.request.content.launchImageName;
    NSString *noticeType = response.notification.request.content.threadIdentifier;
    NSLog(@"收到通知：%@",response.notification.request.content);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    NSLog(@"%@", categoryIdentifier);
    NSLog(@"%@", subTitle);
    
    if ([type isEqualToString:@"1"])
    {
        if ([noticeType isEqualToString:@"1"])
        {
            self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:1];
        }
        else if ([noticeType isEqualToString:@"2"])
        {
            
        }
        else if ([noticeType isEqualToString:@"3"])
        {
            self.tabbarController.selectedViewController = [self.tabbarController.viewControllers objectAtIndex:2];
        }
        else if ([noticeType isEqualToString:@"4"])
        {
            
        }
        else if ([noticeType isEqualToString:@"5"])
        {
            
        }
        else if ([noticeType isEqualToString:@"6"])
        {
            
        }
        else if ([noticeType isEqualToString:@"7"])
        {
            
        }
        else if ([noticeType isEqualToString:@"8"])
        {
            
        }
        else if ([noticeType isEqualToString:@"9"])
        {
//            [self getMoreDetailContentWithId:categoryIdentifier andTitle:subTitle];
        }
    }
    else if ([type isEqualToString:@"2"])
    {
        
    }
    else if ([type isEqualToString:@"3"])
    {
        
    }
    else if ([type isEqualToString:@"4"])
    {
        
    }
    else if ([type isEqualToString:@"5"])
    {
        
    }
    else if ([type isEqualToString:@"6"])
    {
        
    }
    else if ([type isEqualToString:@"7"])
    {
        
    }
    else if ([type isEqualToString:@"8"])
    {
        
    }
    else if ([type isEqualToString:@"9"])
    {
        
    }
    
    
    completionHandler();
    
}

#pragma mark - 调取公告详情内容
-(void)getMoreDetailContentWithId:(NSString *)idd
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"Messageid"];
    __weak typeof(self) weakSelf = self;
    [AFOwnerHTTPSessionManager getAddToken:GetAgentDetailMessage Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *str = responseObject[@"code"];
        if ([str isEqualToString:@"0000"])
        {
            LYSkipViewController *serVC = [[LYSkipViewController alloc] init];
            serVC.title = responseObject[@"Data"][@"Title"];
            serVC.urlString = responseObject[@"Data"][@"Content"];
            serVC.type = @"1";
            [weakSelf.window.rootViewController presentViewController:[[LYNavigationController alloc] initWithRootViewController:serVC] animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

-(void)setUpUserData
{
    LYUserInfo *userInfo = UserInfoData;
    if (userInfo.username.length == 0)//userName为指定id不可改动用来判断是否有用户数据
    {
        LYUserInfo *userInfo = [[LYUserInfo alloc] init];
        userInfo.userimage = @"头像";
        userInfo.nickname = @"RocketChen";
        userInfo.sex = @"男";
        userInfo.birthDay = @"1993-07-23";
        userInfo.username = @"qq-w1210578014";
        userInfo.defaultAddress = @"浙江 杭州萧山区";
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步线程保存
            [userInfo save];//保存
//            [userInfo deleteObject];//删除
        });
    }
}

#pragma mark - 分享
-(void)setUpShare
{
    [OpenShare connectQQWithAppId:@"1106565273"];
    [OpenShare connectWeixinWithAppId:@"wx6379d505bd0d4401" miniAppId:@"gh_d43f693ca31f"];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}

/**
 *  引导页到主页
 */
- (void)qieHuan {
    
    self.window.rootViewController = self.tabbarController;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:@"YES" forKey:@"firstLogin"];
    [user synchronize];
}


#pragma mark ====版本更新
/**
 *  检测版本更新(后台可控制, 可强更)
 */
- (void)appUpDate
{
    NSDictionary *dic = @{
                          @"editionType": @"2"
                          };
    [AFOwnerHTTPSessionManager get:Getedition Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSDictionary *dicVersion = responseObject[@"Data"];
            if (dicVersion)
            {
                _appleId = dicVersion[@"appId"];
                //2先获取当前工程项目版本号
                NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
                NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
                //打印版本号
                NSLog(@"当前版本号:%@",currentVersion);
                currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSLog(@"当前版本号:%@",currentVersion);
                if (currentVersion.length==2) {
                    currentVersion  = [currentVersion stringByAppendingString:@"0"];
                }else if (currentVersion.length==1){
                    currentVersion  = [currentVersion stringByAppendingString:@"00"];
                }
                NSLog(@"%@", currentVersion);
                NSString *appStoreVersion  = dicVersion[@"edition_No"];
                appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                if (appStoreVersion.length==2) {
                    appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
                }else if (appStoreVersion.length==1){
                    appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
                }
                NSLog(@"%@", appStoreVersion);
                
                //4当前版本号小于商店版本号,就更新
                if([currentVersion floatValue] < [appStoreVersion floatValue] && [dicVersion[@"ForcedToupdate"] integerValue] == 0)
                {
                    if (!_view) 
                    {
                        _view = [[LYForceUpdateView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                        _view.appleID = _appleId;
                        [self.window addSubview:_view];
                        [_view.upDateBtn setImage:[UIImage imageNamed:@"更新"]];
                    }
                    
                }//强制更新
                else if ([currentVersion floatValue] < [appStoreVersion floatValue] && [dicVersion[@"ForcedToupdate"] integerValue] == 1){
                    
                    [self ruangengApp];
                }
                else{
                    NSLog(@"版本号好像比商店大噢!检测到不需要更新");
                }
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}


-(void)ruangengApp
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"新版本已经发布，是否去更新" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", _appleId]];
        [[UIApplication sharedApplication] openURL:url];
        
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
