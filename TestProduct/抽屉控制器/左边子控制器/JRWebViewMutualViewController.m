//
//  JRWebViewMutualViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/21.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRWebViewMutualViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JRWebViewMutualViewController ()<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView * mainWebView;


@end

@implementation JRWebViewMutualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainWebView];
    self.mainWebView.delegate = self;
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.173:8080/login.html"]]];
    self.mainWebView.scalesPageToFit = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 初始化JSContext
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *jsFunctStr= [NSString stringWithFormat:@"submitLogin()"];
    [context evaluateScript:jsFunctStr];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载错误：%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
