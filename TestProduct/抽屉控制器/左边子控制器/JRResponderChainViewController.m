//
//  JRResponderChainViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/10.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRResponderChainViewController.h"
#import "JRTestView_red.h"
#import "JRTestView_yellow.h"
#import "JRTestView_blue.h"



@interface JRResponderChainViewController ()

@property (nonatomic, strong)JRTestView_red * redView;
@property (nonatomic, strong)JRTestView_yellow * yellowView;
@property (nonatomic, strong)JRTestView_blue * blueView;

@end

@implementation JRResponderChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"响应者链";
    self.yellowView = [[JRTestView_yellow alloc] initWithFrame:CGRectMake(20, 150, 260, 400)];
    self.yellowView.backgroundColor = [UIColor yellowColor];
//    self.yellowView.hidden = YES;
    [self.view addSubview:self.yellowView];
    
    self.redView = [[JRTestView_red alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
//    [self.redView setUserInteractionEnabled:NO];
    
    self.blueView = [[JRTestView_blue alloc] initWithFrame:CGRectMake(100, 300, 100, 300)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.yellowView addSubview:self.blueView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
