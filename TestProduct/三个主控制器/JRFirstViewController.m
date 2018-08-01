//
//  JRFirstViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import <RPSDK/RPSDK.h>


typedef void(^TestBlock)(void);

#import "JRFirstViewController.h"
#import "JRCodeEncryptOrDecrypt.h"

@interface JRFirstViewController ()

@property(strong,nonatomic)UIButton * testButton;
@property(strong,nonatomic)UIButton * testButton_1;

@property (nonatomic,strong) NSMutableArray * testArray;
@property(copy,nonatomic) TestBlock testBlock;


@end

@implementation JRFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%s", __func__);
    _testButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_testButton setFrame:CGRectMake(100, 200, 100, 50)];
    [_testButton setBackgroundColor:[UIColor blueColor]];
    [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_testButton];
    
    _testButton_1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_testButton_1 setFrame:CGRectMake(100, 400, 100, 50)];
    [_testButton_1 setBackgroundColor:[UIColor blueColor]];
    [_testButton_1 addTarget:self action:@selector(otherTestButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_testButton_1];
    
}

- (void)testButtonAction
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:@"http://10.50.12.50:8080/face/idcardlivedetectfour"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSString *str = [[NSBundle mainBundle] resourcePath];
    NSString *filePathStr = [NSString stringWithFormat:@"%@%@",str,@"/1234.mp4"];
    NSURL *filePath = [NSURL fileURLWithPath:filePathStr];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
        NSLog(@"dddd");
    }];
    [uploadTask resume];
    
}
- (void)otherTestButtonAction
{
    [RPSDK start:@"aa351325e6624b85bb61949b598ad0ab" rpCompleted:^(AUDIT auditState) {
        NSLog(@"verifyResult = %ld",(unsigned long)auditState);
        if(auditState == AUDIT_PASS) { //认证通过
        }
        else if(auditState == AUDIT_FAIL) { //认证不通过
        }
        else if(auditState == AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
        }
        else if(auditState == AUDIT_NOT) { //未认证，用户取消
        }
        else if(auditState == AUDIT_EXCEPTION) { //系统异常
        }
    }withVC:self.navigationController];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    NSLog(@"%s", __func__);
//}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidDisappear:(BOOL)animated;
//{
//    NSLog(@"%s", __func__);
//}
//
//// 在视图控制器视图的layoutSubviews方法被调用之前调用
//- (void)viewWillLayoutSubviews
//{
//    NSLog(@"%s", __func__);
//}
//
//- (void)viewDidLayoutSubviews
//{
//    NSLog(@"%s", __func__);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
