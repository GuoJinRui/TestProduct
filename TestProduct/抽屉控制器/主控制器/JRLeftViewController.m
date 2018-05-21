//
//  JRLeftViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRLeftViewController.h"
#import "JRArrayStructureViewController.h"
#import "JRDictionaryStructureViewController.h"
#import "JRClassStructureViewController.h"
#import "JRResponderChainViewController.h"
#import "GCDViewController.h"
#import "JRWebViewMutualViewController.h"

@interface JRLeftViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _pushClassName;
}

@property(strong,nonatomic)UITableView * mainTableView;
@property(strong,nonatomic)NSMutableArray * dataArray;

@end

@implementation JRLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"左控制器";
    self.dataArray = [NSMutableArray arrayWithObjects:@"NSArray结构", @"NSDictionary结构", @"Class结构", @"响应者链测试", @"GCD", @"webView交互", nil];
//    _pushClassName = @[@"JRArrayStructureViewController", @"JRDictionaryStructureViewController", @"JRClassStructureViewController", @"JRResponderChainViewController"];
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self centerVCPushNextVCWithIndexPath:indexPath];
    UIViewController * VC;
    switch (indexPath.row) {
        case 0:{
            VC = [JRArrayStructureViewController new];
            }
            break;
        case 1:{
            VC = [JRDictionaryStructureViewController new];
        }
            break;
        case 2:{
            VC = [JRClassStructureViewController new];
        }
            break;
        case 3:{
            VC = [JRResponderChainViewController new];
        }
            break;
        case 4:{
            VC = [GCDViewController new];
        }
            break;
        case 5:{
            VC = [JRWebViewMutualViewController new];
        }
            break;
        default:
            break;
    }
    MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        UITabBarController * tabBarController = (UITabBarController *)drawerController.centerViewController;
        [tabBarController.selectedViewController pushViewController:VC animated:YES];
    }];
}

- (void)centerVCPushNextVCWithIndexPath:(NSIndexPath *)indexPath
{
    NSString * classStr = _pushClassName[indexPath.row];
    MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        UITabBarController * tabBarController = (UITabBarController *)drawerController.centerViewController;
        [tabBarController.selectedViewController pushViewController:[[NSClassFromString(classStr) alloc] init] animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
