//
//  SHPresentationController.m
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPresentationController.h"


@interface SHPresentationController ()

@property (nonatomic, strong) UIView *coverView;

@end
@implementation SHPresentationController

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    // 1.设置弹出View的尺寸
    self.presentedView.frame = self.presentedF;
    [self setupCoverView];
}

- (void)setupCoverView
{
    // 添加蒙版
    [self.containerView insertSubview:self.coverView atIndex:0];
    
}

- (void)coverViewClick
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters
- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [SHCustomControlTool sh_customViewBgColor:[UIColor colorWithWhite:0.8 alpha:0.2]];
        _coverView.frame = self.containerView.bounds;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
        
        [_coverView addGestureRecognizer:tapGes];
    }
    return _coverView;
}
@end
