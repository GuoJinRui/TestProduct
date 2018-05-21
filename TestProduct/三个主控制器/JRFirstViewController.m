//
//  JRFirstViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

typedef void(^TestBlock)(void);

#import "JRFirstViewController.h"
#import "JRCodeEncryptOrDecrypt.h"

@interface JRFirstViewController ()

@property(strong,nonatomic)UIButton * testButton;
@property (nonatomic,strong) NSMutableArray * testArray;
@property(copy,nonatomic) TestBlock testBlock;


@end

@implementation JRFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%s", __func__);
    _testButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_testButton setFrame:CGRectMake(100, 0, 100, 50)];
    [_testButton setBackgroundColor:[UIColor blueColor]];
    [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_testButton];
    
}

- (void)testButtonAction
{
//    NSString * encryptStr = [[JRCodeEncryptOrDecrypt shareCodeEncryptOrDecrypt] encryptString:@"军哥威武"];
//    NSLog(@"encryptStr = %@", encryptStr);
    
    __block int aaa  = 15;
    UIView * aView = [[UIView alloc] init];
    __weak typeof(aView) weakView;
    self.testBlock = ^{
        aaa  += 10;
        NSLog(@"block内部aaa = %d", aaa);
//        aView.frame = CGRectMake(100, 100, 200, 200);//在block内部使用view对象，系统会对view强引用，此时会造成内存泄漏。
        weakView.frame = CGRectMake(100, 100, 200, 200);
    };
    self.testBlock();
    NSLog(@"block外部aaa = %d", aaa);

    
    
    
    
    
    
    
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
