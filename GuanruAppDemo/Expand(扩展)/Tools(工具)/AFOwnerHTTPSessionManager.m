// AFOwnerHTTPSessionManager.m
//
//  Created by wangze on 15/8/30.
//  Copyright (c) 2015年 wangze. All rights reserved.
//

#import "AFOwnerHTTPSessionManager.h"
#import "LYLoginViewController.h"
#import "LYNavigationController.h"
//static NSString * const AFOwnerHTTPSessionManagerBaseURLString = @"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?";

static NSString * const AFOwnerHTTPSessionManagerBaseURLString = @"http://192.168.1.11";


@implementation AFOwnerHTTPSessionManager

+ (instancetype)shareManager
{
    static AFOwnerHTTPSessionManager *ownerManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        ownerManager = [[AFOwnerHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:Localhost]];
        
        //设置json序列化
        [ownerManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        //设置请求超时的时间
        ownerManager.requestSerializer.timeoutInterval = 15;
        //设置与服务器和前端所有可相互识别的方式
        ownerManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });
    
    return ownerManager;
}


+ (void)get:(NSString *)url Parameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    NSInteger state = [DCSpeedy checkNetwork];
    if (state == 0)
    {
        [DCSpeedy alertMes:@"没有网络"];
    }
    else
    {
        [[AFOwnerHTTPSessionManager shareManager] GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSLog(@"%@", responseObject);
            NSString *code = responseObject[@"code"];
            NSString *msg = responseObject[@"msg"];
            if ([code isEqualToString:@"0002"])
            {
                LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            else if([code isEqualToString:@"0000"])
            {
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            else
            {
                if (msg)
                {
                    [DCSpeedy alertMes:msg];
                }
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [DCSpeedy alertMes:@"服务器维护中"];
                });
                //block传递参数，类似代理传值
                failure(task, error);
            }
    
        }];
    }
    
}

+ (void)getAddToken:(NSString *)url Parameters:(id)parameters
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    NSInteger state = [DCSpeedy checkNetwork];
    if (state == 0)
    {
        [DCSpeedy alertMes:@"没有网络"];
    }
    else
    {
        AFOwnerHTTPSessionManager *shareManager = [DCSpeedy userToken];
        [shareManager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSString *code = responseObject[@"code"];
            NSString *msg = responseObject[@"msg"];
            if ([code isEqualToString:@"0002"])
            {
                LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            else if([code isEqualToString:@"0000"])
            {
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            else
            {
                if (msg)
                {
                    [DCSpeedy alertMes:msg];
                }
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [DCSpeedy alertMes:@"服务器维护中"];
                });
                //block传递参数，类似代理传值
                failure(task, error);
            }
        }];
    }
    
}


+ (void)post:(NSString *)url Parameters:(id)parameters
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    NSInteger state = [DCSpeedy checkNetwork];
    if (state == 0)
    {
        [DCSpeedy alertMes:@"没有网络"];
    }
    else
    {
        [[AFOwnerHTTPSessionManager shareManager] POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSString *code = responseObject[@"code"];
            NSString *msg = responseObject[@"msg"];
            if ([code isEqualToString:@"0002"])
            {
                LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            else if([code isEqualToString:@"0000"])
            {
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            else
            {
                if (msg)
                {
                    [DCSpeedy alertMes:msg];
                }
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [DCSpeedy alertMes:@"服务器维护中"];
                });
                //block传递参数，类似代理传值
                failure(task, error);
            }
        }];
    }
    
}


+ (void)postAddToken:(NSString *)url Parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    NSInteger state = [DCSpeedy checkNetwork];
    if (state == 0)
    {
        [DCSpeedy alertMes:@"没有网络"];
    }
    else
    {
        AFOwnerHTTPSessionManager *shareManager = [DCSpeedy userToken];
        [shareManager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSString *code = responseObject[@"code"];
            NSString *msg = responseObject[@"msg"];
            if ([code isEqualToString:@"0002"])
            {
                LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }
            else if([code isEqualToString:@"0000"])
            {
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            else
            {
                if (msg)
                {
                    [DCSpeedy alertMes:msg];
                }
                //block传递参数，类似代理传值
                success(task, responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [DCSpeedy alertMes:@"服务器维护中"];
                });
                //block传递参数，类似代理传值
                failure(task, error);
            }
        }];
    }
    
}

//上传文件
+ (void)uploadFileParameters:(id)parameters
   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                progress:(void (^)(NSProgress *))progress
                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
//    [manager POST:@"http://www.dcjyxwzx.cn/upload/change_avatar" parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * uploadProgress) {
//
//        //block传递参数，类似代理传值
//        progress(uploadProgress);
//
//    } success:^(NSURLSessionDataTask *task, id  responseObject) {
//
//        //block传递参数，类似代理传值
//        success(task, responseObject);
//
//    } failure:^(NSURLSessionDataTask * task, NSError *error) {
//
//        //block传递参数，类似代理传值
//        failure(task, error);
//
//    }];
    
    [manager POST:@"http://www.dcjyxwzx.cn/upload/change_avatar" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


//网络监听

//启动网络监测，app启动的时候加载一次就可以
//[AFOwnerHTTPSessionManager AFNetworkStatus];
+ (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
    
    //启动网络监测
    [manager startMonitoring];
}


@end
