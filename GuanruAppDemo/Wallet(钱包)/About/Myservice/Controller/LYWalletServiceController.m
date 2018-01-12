//
//  LYWalletServiceController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/1.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYWalletServiceController.h"
// Controllers

// Models

// Views

// Vendors
#import <WebKit/WebKit.h>
#import "SVProgressHUD.h"
// Categories

// Others

@interface LYWalletServiceController ()<WKNavigationDelegate>
//WKWebView
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation LYWalletServiceController

#pragma mark - LazyLoad

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    [self setUpNav];
    
    [self setUpGoodsParticularsWKWebView];
}

- (void)setUpBase
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = self.view.backgroundColor;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    //    //异步发送通知
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissSVHUD" object:nil];
    //    });
    
}

#pragma mark - 设置导航栏
-(void)setUpNav
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"jiantouback"] forState:0];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setUpGoodsParticularsWKWebView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //    [SVProgressHUD showWithStatus:@"加载中"];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}

-(void)rightBarClick
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
