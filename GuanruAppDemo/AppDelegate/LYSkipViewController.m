//
//  LYSkipViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/3/7.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import "LYSkipViewController.h"
// Controllers

// Models

// Views

// Vendors
#import <WebKit/WebKit.h>
#import "SVProgressHUD.h"
// Categories

// Others

@interface LYSkipViewController ()<WKNavigationDelegate>
//WKWebView
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation LYSkipViewController

#pragma mark - LazyLoad

- (WKWebView *)webView
{
    if (!_webView) {
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        if ([_type isEqualToString:@"1"])
        {
            _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        }
        else
        {
            _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        }
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
    if ([_urlString hasPrefix:@"http"])
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [self.webView loadRequest:request];
    }
    else
    {
//        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
//                           "<head> \n"
//                           "<style type=\"text/css\"> \n"
//                           "body {font-size:36px;}\n"
//                           "</style> \n"
//                           "</head> \n"
//                           "<body>"
//                           "<script type='text/javascript'>"
//                           "window.onload = function(){\n"
//                           "var $img = document.getElementsByTagName('img');\n"
//                           "for(var p in  $img){\n"
//                           " $img[p].style.width = '100%%';\n"
//                           "$img[p].style.height ='auto'\n"
//                           "}\n"
//                           "}"
//                           "</script>%@"
//                           "</body>"
//                           "</html>",self.urlString];
        [self.webView loadHTMLString:self.urlString baseURL:nil];
    }
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
