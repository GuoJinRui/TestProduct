
//
//  JRPopoverMiddleViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/8.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRPopoverMiddleViewController.h"
#import "JRPopoverPresentationController.h"

@interface JRPopoverMiddleViewController ()

@property(strong,nonatomic)UIButton * testButton;
@property(strong,nonatomic)JRPopoverPresentationController * popoverC;



@end

@implementation JRPopoverMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _testButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_testButton setFrame:CGRectMake(100, 200, 100, 50)];
    [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_testButton];
//    [_testButton makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(100);
//        make.right.equalTo(-100);
//        make.top.equalTo(300);
//        make.height.equalTo(50);
//    }];
    _testButton.backgroundColor = [UIColor redColor];
}

- (void)testButtonAction
{
    if (!self.popoverC) {
        self.popoverC = [JRPopoverPresentationController new];
        UIPopoverPresentationController * popover = self.popoverC.popoverPresentationController;
        popover.sourceView = self.testButton;
        // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
        // 这个可以 通过 Point 或  Size 调试位置
        popover.sourceRect = self.testButton.bounds;
    }
    [self presentViewController:self.popoverC animated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
