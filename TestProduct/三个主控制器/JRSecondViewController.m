//
//  JRSecondViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRSecondViewController.h"
#import <objc/message.h>

@interface JRSecondViewController ()

@property (nonatomic,strong) UIScrollView * noteScrollView;
@property (nonatomic,strong) UILabel * noteLabel;

@end

@implementation JRSecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteScrollView = [UIScrollView new];
    self.noteScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.noteScrollView];
    self.noteLabel = [UILabel new];
    self.noteLabel.backgroundColor = [UIColor whiteColor];
    self.noteLabel.font = [UIFont systemFontOfSize:13];
    self.noteLabel.textColor = [UIColor blackColor];
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.text = @"dfalsdfla;sdf;alsdfasdflasdof;alsdlfalsdfasdlfa;dslfa;sldfkadsfkadsfadsfkadskfjadsfjasdfjasdfklasdfadflasdflasdlkfaslkdfjaksdfaksdfkadsflaksdfladsflasdfkladfladlfadslf \n adsfasdfasdfasdfadsfas";
    [self.noteScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
}

- (void)viewWillLayoutSubviews
{
    [self.noteScrollView addSubview:self.noteLabel];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.noteScrollView);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
