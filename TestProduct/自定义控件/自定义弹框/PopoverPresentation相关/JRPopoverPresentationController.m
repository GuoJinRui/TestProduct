//
//  JRPopoverPresentationController.m
//  TestProduct
//
//  Created by homebox on 2018/5/8.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRPopoverPresentationController.h"

@interface JRPopoverPresentationController()<UIPopoverPresentationControllerDelegate>

@property(strong,nonatomic)UIPopoverPresentationController * popover;


@end

@implementation JRPopoverPresentationController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 必须设置该属性为UIModalPresentationPopover
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popover = self.popoverPresentationController;
        self.popover.delegate = self;
        self.popover.backgroundColor = [UIColor redColor];
        // 允许弹出窗口的箭头方向
        self.popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.preferredContentSize = CGSizeMake(110, 160);
        self.popover = self.popoverPresentationController;
        self.popover.delegate = self;
        self.popover.backgroundColor = [UIColor colorWithRed:63/255.0 green:66/255.0 blue:75/255.0 alpha:1.000];
        // 允许弹出窗口的箭头方向
        self.popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

// 点击蒙版视图消失
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    
}


@end
