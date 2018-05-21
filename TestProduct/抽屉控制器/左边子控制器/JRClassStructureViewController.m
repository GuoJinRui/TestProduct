//
//  JRClassStructureViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/9.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRClassStructureViewController.h"
#import <objc/runtime.h>

@interface JRClassStructureViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong,nonatomic)UITableView * mainTableView;
@property(strong,nonatomic)NSMutableArray * dataArray;
@property(strong,nonatomic)NSArray * array;


@end

@implementation JRClassStructureViewController

// 测试用类方法
+ (void)testClassMethod_1{
    
}

+ (void)testClassMethod_2{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"类结构";
    self.array = @[[UIColor redColor]];
    self.dataArray = [NSMutableArray arrayWithObjects:@"获取元类与类的相关关系", @"获取类结构", nil];
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
    switch (indexPath.row) {
        case 0:{
            [self printMetaClassMethod];
        }
            break;
        case 1:{
            // 实例变量调用class 方法实际上是调用了object_getClass(实例变量)这一方法，返回实例变量isa指针指向的对象，而类对象调用class方法返回的就是自己！
            NSLog(@"可变数组实例变量：%@, 不可变数组实例变量：%@, 类对象%@", [self.dataArray class], [self.array class], [NSMutableArray class]);
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
        default:{
        }
            break;
    }
}

// 打印验证元类与类的关系
- (void)printMetaClassMethod
{
    const char * name = object_getClassName(self);
    Class metaClass = objc_getMetaClass(name);
    NSLog(@"元类及地址：%@:%p",metaClass,metaClass);
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++){
        NSLog(@"isa指针指向的当前类%@:%p", currentClass, currentClass);
        unsigned int countMethod = 0;
        NSLog(@"\n---------------** i == %d 方法打印开始 **-----------------------",i);
        // 获取类实现的实例方法 第一个参数是类，第二个参数返回实例方法列表长度，即count，返回描述实例方法的类型为Method的指针数组(Method *)
        // 要获取类的类方法，使用class_copyMethodList（object_getClass（cls），＆count）
        Method * methods = class_copyMethodList(currentClass, &countMethod);
        [self printMethod:countMethod methods:methods ];
        NSLog(@"---------------** i == %d 方法打印结束 **------------------------\n",i);
        // object_getClass():参数是id类型,它返回的是这个id类型的isa指针所指向的Class，如果传参是Class，则返回该Class的metaClass。
        // 在此处要和objc_getClass()作用区分开，这个函数参数是类名的字符串，返回的就是这个类的类对象。
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject的地址：%p", [NSObject class]);
    NSLog(@"NSObject的元类的地址：%p", object_getClass([NSObject class]));
    NSLog(@"NSObject的元类的父类的地址：%p", [object_getClass([NSObject class]) superclass]);
}
// 打印方法列表
- (void)printMethod:(int)count methods:(Method *) methods{
    for (int j = 0; j < count; j++) {
        Method method = methods[j];
        SEL methodSEL = method_getName(method);
        const char * selName = sel_getName(methodSEL);
        if (methodSEL) {
            NSLog(@"方法名 ------ %s", selName);
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
