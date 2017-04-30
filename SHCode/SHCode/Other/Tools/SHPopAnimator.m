//
//  SHPopAnimator.m
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPopAnimator.h"
#import "SHPresentationController.h"

@implementation SHPopAnimator

- (instancetype)initWithCallBack:(callBack)callBack
{
    self = [super init];
    if (self) {
        self.callBack = callBack;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    SHPresentationController *presentation = [[SHPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.presentedF = self.presentedF;
    return presentation;
}

//自定义弹出动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.popPresented = YES;
    self.callBack(self.popPresented);
    return self;
}
//自定义消失动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.popPresented = NO;
    self.callBack(self.popPresented);
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.popPresented ? [self animationForPresentedView:transitionContext] : [self animationForDismissedView:transitionContext];
}

/// 获取`转场的上下文`:可以通过转场上下文获取弹出的View和消失的View
// UITransitionContextFromViewKey : 获取消失的View
// UITransitionContextToViewKey : 获取弹出的View

/// 自定义弹出动画
- (void)animationForPresentedView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1.获取弹出的View
   UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 2.将弹出的View添加到containerView中
    [[transitionContext containerView] addSubview:presentedView];
    //执行动画
    presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentedView.layer.anchorPoint = CGPointMake(0.5, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentedView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 必须告诉转场上下文你已经完成动画
        [transitionContext completeTransition:YES];
    }];
    
}

/// 自定义消失动画
- (void)animationForDismissedView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1.获取消失的View
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dismissView.transform = CGAffineTransformMakeScale(1.0, 0.0001);
    } completion:^(BOOL finished) {
        // 必须告诉转场上下文你已经完成动画
        [transitionContext completeTransition:YES];
    }];

}



@end
