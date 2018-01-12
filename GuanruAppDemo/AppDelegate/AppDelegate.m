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

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate>

@property(nonatomic, strong) LYTabbarController *tabbarController;

@property (nonatomic, strong) LYForceUpdateView *view;//强更视图

@property(nonatomic, strong) NSString *appleId;

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
    //自定义
//    [self zdyNoticaton];
    
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
            NSArray *mArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];
            if (mArr.count == 0)
            {
                NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:1];
                [[NSUserDefaults standardUserDefaults] setObject:mutableArr forKey:@"mutableArr"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [[NSUserDefaults standardUserDefaults] setObject:mArr forKey:@"mutableArr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    [self zdyNoticaton];
    
    
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
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
            //最后把Iconbadge归0
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];
        NSMutableArray *ar = [NSMutableArray arrayWithArray:arr];
        NSString *mesStr = userInfo[@"aps"][@"alert"];
        NSLog(@"%@", mesStr);
        NSString *timeStr = [DCSpeedy getNowTimeTimestamp];
        NSString *date = [DCSpeedy timeStampToStr:timeStr];
        NSDictionary *dic = @{
                              @"mesStr" : mesStr,
                              @"date" : date
                              };
        [ar addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:ar forKey:@"mutableArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
//后台得到的的通知对象(当用户点击通知栏的时候)
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //你要处理的逻辑
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
            //最后把Iconbadge归0
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];
        NSMutableArray *ar = [NSMutableArray arrayWithArray:arr];
        NSString *mesStr = userInfo[@"aps"][@"alert"];
        NSString *timeStr = [DCSpeedy getNowTimeTimestamp];
        NSString *date = [DCSpeedy timeStampToStr:timeStr];
        NSDictionary *dic = @{
                              @"mesStr" : mesStr,
                              @"date" : date
                              };
        [ar addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:ar forKey:@"mutableArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];

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
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSLog(@"%@", userInfo);
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
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
