//
//  JRWebViewMutualViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/21.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRWebViewMutualViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

// JS调用OC
@protocol JSObjcDelegate <JSExport>
//协议的方法必须和JS里面的方法名称保持一致才有效!
- (void)callShare;

@end


@interface JRWebViewMutualViewController ()<UIWebViewDelegate, JSObjcDelegate>

@property (nonatomic,strong) JSContext * jsContext;// 获取交互环境，主要用于调取JS代码
@property(strong,nonatomic)UIWebView * mainWebView;

@end

@implementation JRWebViewMutualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * rightBut_1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBut_1.tag = 10000;
    [rightBut_1 setTitle:@"webView自带" forState:(UIControlStateNormal)];
    [rightBut_1 addTarget:self action:@selector(rightButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem * rightItem_1 = [[UIBarButtonItem alloc] initWithCustomView:rightBut_1];
    
    UIButton * rightBut_2= [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBut_2.tag = 10001;
    [rightBut_2 setTitle:@"JSCore调用JS" forState:(UIControlStateNormal)];
    [rightBut_2 addTarget:self action:@selector(rightButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem * rightItem_2 = [[UIBarButtonItem alloc] initWithCustomView:rightBut_2];
    self.navigationItem.rightBarButtonItems = @[rightItem_1, rightItem_2];
    self.mainWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mainWebView];
    self.mainWebView.delegate = self;
    NSString * str = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
//    NSURL *pathUrl = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 原始的JS调用OC，拦截URL，重定向
    // 这里我在 index.html中采用了两种方式进行request返回，1：onclick="window.open('need://transform')"；2：onclick="window.location.href='need://location'"
    if ([request.URL.absoluteString hasPrefix:@"need://transform"]) {// 跳转
        NSLog(@"执行了跳转操作");
        return NO;
    }
    if ([request.URL.absoluteString hasPrefix:@"need://location"]) {// 本界面的一些操作
        NSLog(@"执行了本界面操作");
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [self.mainWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.jsContext[@"callCamera"] = ^() {
        NSLog(@"调用Camera了🙄");
    };
    
    /**
        在JS中 onclick="callCamera()" 指的是点击button直接触发callCamera方法；
        onclick="TEXT.callShare() 指点击button会让一个叫做TEXT的对象去触发callShare方法;
     */
    
    //在使用JSExport协议类时必须有指定的执行对象才能使用否则使用block形式的回调即可
    self.jsContext[@"TEXT"] = self;
    // 若发生异常会执行此方法
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"异常信息是%@",exception);
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载错误：%@", error);
}

- (void)rightButAction:(UIButton *)sender
{
    if (sender.tag == 10000) {
        // 使用UIWebView自带方法调用JS方法，其中picCallback('%@')是JS方法，@"title"是参数
        NSString * jsStr = [NSString stringWithFormat:@"picCallback('%@')", @"stringByEvaluatingJavaScriptFromString方法实现"];
        [self.mainWebView stringByEvaluatingJavaScriptFromString:jsStr];
    }else{
        // 获取 将字符串对应的JS方法，转换成一个JSValue对象
        JSValue * jsValue = [self.jsContext evaluateScript:@"picCallback"];
        // 下面👇这一方法与上面的等效
//        JSValue * jsValue = self.jsContext[@"picCallback"];
        // 作为一个函数调用JSValue 参数是JS函数所需参数,该方法用于传参
        [jsValue callWithArguments:@[@"javaScript实现"]];
        
        // 与上面两句代码等效代码
//        [self.jsContext evaluateScript:[NSString stringWithFormat:@"picCallback('%@')", @"javaScript实现"]];
    }
}

- (void)callShare
{
    NSLog(@"调用Share了🙄");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
