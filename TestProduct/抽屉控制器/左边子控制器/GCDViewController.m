//
//  GCDViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/11.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong,nonatomic)UITableView * mainTableView;
@property(strong,nonatomic)NSMutableArray * dataArray;

@end

@implementation GCDViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"GCD";
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"dispatch_group组内同步", @"dispatch_group组内异步",  @"dispatch_group组外异步"], @[@"dispatch_barrid"], @[@"dispatch_simp"], nil];
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [self disaptch_groupTest_sync];
                }
                    break;
                    
                case 1:{
                    [self disaptch_groupTest_async];

                }
                    break;
                    
                case 2:{
                    
                }
                    break;
                    
                default:{
                }
                    break;
            }
        }
            break;
            
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    
                }
                    break;
                    
                case 1:{
                    
                }
                    break;
                    
                case 2:{
                    
                }
                    break;
                    
                default:{
                }
                    break;
            }
        }
            break;
            
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    
                }
                    break;
                    
                case 1:{
                    
                }
                    break;
                    
                case 2:{
                    
                }
                    break;
                    
                default:{
                }
                    break;
            }
        }
            break;
            
        default:{
        }
            break;
    }
}

// 调度组测试

// 内部同步执行
- (void)disaptch_groupTest_sync
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            sleep(1);
            dispatch_sync(concurrentQueue, ^{
                NSLog(@"组内同步001 == %d", i);
            });
        }
    });
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            sleep(1);
            dispatch_sync(concurrentQueue, ^{
                NSLog(@"组内同步002 == %d", i);
            });
        }
    });
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"组内同步结束");
    });
}

// 内部异步执行
- (void)disaptch_groupTest_async
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            sleep(1);
            dispatch_async(concurrentQueue, ^{
                NSLog(@"组内异步001 == %d", i);
            });
        }
    });
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            sleep(1);
            dispatch_async(concurrentQueue, ^{
                NSLog(@"组内异步002 == %d", i);
            });
        }
    });
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"组内异步结束");
    });
}

// 栅栏测试
- (void)disaptch_barrierTest
{
//    dispatch_barrier_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
}

// 信号量测试
- (void)dispatch_semaphoreTest
{
//    dispatch_semaphore_t
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
