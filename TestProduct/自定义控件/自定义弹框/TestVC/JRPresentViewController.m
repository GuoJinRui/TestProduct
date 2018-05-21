//
//  JRPresentViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/2.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRPresentViewController.h"
#import "JRTransitionDelegate.h"


@interface JRPresentViewController ()

@end

@implementation JRPresentViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = [JRTransitionDelegate sharedTransition];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = [JRTransitionDelegate sharedTransition];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectInset(self.view.bounds, 50, 100).size.width, CGRectInset(self.view.bounds, 50, 100).size.height)];
    [imageView setImage:[UIImage imageNamed:@"003"]];
    [self.view addSubview:imageView];
    [self.view.layer masksToBounds];
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
