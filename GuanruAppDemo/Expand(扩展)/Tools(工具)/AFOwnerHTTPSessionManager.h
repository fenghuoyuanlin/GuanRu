// AFOwnerHTTPSessionManager.h
//
//  Created by wangze on 15/8/30.
//  Copyright (c) 2015年 wangze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

//自己写的类要继承AFHTTPSessionManager
@interface AFOwnerHTTPSessionManager : AFHTTPSessionManager

@property(nonatomic, strong) AFURLSessionManager *urlSessionManager;

+ (instancetype)shareManager;

//get请求(没有添加token)
+ (void)get:(NSString *)url Parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//get请求(添加token)
+ (void)getAddToken:(NSString *)url Parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//post请求(没有添加token)
+ (void)post:(NSString *)url Parameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

//post请求(添加token)
+ (void)postAddToken:(NSString *)url Parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


//上传文件
+ (void)uploadFileParameters:(id)parameters
  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                   progress:(void (^)(NSProgress *))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//网络监测
+ (void)AFNetworkStatus;


@end
