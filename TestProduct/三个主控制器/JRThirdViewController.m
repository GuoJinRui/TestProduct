//
//  JRThirdViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRThirdViewController.h"
#import "JRPresentViewController.h"
#import "JRPopoverMiddleViewController.h"


@interface JRThirdViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView * _barImageView;
}

@property(strong,nonatomic)UITableView * mainTableView;
@property(strong,nonatomic)NSMutableArray * dataArray;


@end

@implementation JRThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    _barImageView = (UIImageView *)self.navigationController.navigationBar.subviews.firstObject;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    self.dataArray = [NSMutableArray arrayWithObjects:@"UIPresentationController", @"UIPopoverPresentationController", nil];
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;

//    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
//    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            // presentViewController方法可能不是在主线程执行，则有时会导致反应迟钝问题，将其放到主线程执行present操作即可！
            dispatch_async(dispatch_get_main_queue(), ^{
                JRPresentViewController * presentVC = [JRPresentViewController new];
                [self presentViewController:presentVC animated:YES completion:^{
                    
                }];
            });
        }
            break;
        case 1:{
            // presentViewController方法可能不是在主线程执行，则有时会导致反应迟钝问题，将其放到主线程执行present操作即可！
            dispatch_async(dispatch_get_main_queue(), ^{
                JRPopoverMiddleViewController * popoerVC = [JRPopoverMiddleViewController new];
                [self presentViewController:popoerVC animated:YES completion:^{
                    
                }];
            });
        }
            break;
        default:{
        }
            break;
    }
}

// 非渐变式解决方式即隐藏与显示效果
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    [self.navigationController setNavigationBarHidden:velocity.y>0 animated:YES];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = self.mainTableView.contentOffset.y/64;
    NSLog(@"%f", scale);
    _barImageView.alpha = (1.0-scale);
    
    if ( scale >= 1.0 ) {
        _barImageView.alpha = 0.0;
        self.navigationController.navigationBarHidden = YES;
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
