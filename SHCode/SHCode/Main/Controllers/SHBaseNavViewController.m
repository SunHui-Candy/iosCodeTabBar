//
//  SHBaseNavViewController.m
//  SHCode
//
//  Created by ios on 17/3/28.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHBaseNavViewController.h"

@interface SHBaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SHBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
    NSLog(@"%@",self.interactivePopGestureRecognizer);
    
     解析:
     UIScreenEdgePanGestureRecognizer:导航滑动手势
     target=<_UINavigationInteractiveTransition 0x7fdc4a740440>)
     action=handleNavigationTransition:
     
     <UIScreenEdgePanGestureRecognizer: 0x15be0fb10; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x15bd14da0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x15be0f980>)>>
     */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.enabled = NO;

}

#pragma mark - UIGestureRecognizerDelegate


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger subCount = self.childViewControllers.count;

    if (subCount) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:kImageName(@"navigationButtonReturn") hightImage:kImageName(@"navigationButtonReturnClick") target:self action:@selector(back) title:@"返回"];
    }
    [super pushViewController:viewController animated:YES];
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
