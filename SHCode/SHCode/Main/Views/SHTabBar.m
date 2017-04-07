//
//  SHTabBar.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTabBar.h"

@interface SHTabBar ()

@property (nonatomic, strong) UIButton *plusBtn;

/** 上一次点击的按钮 */

@property (nonatomic, strong) UIControl *previousClickedTabBarButton;

@end

@implementation SHTabBar


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger subViewCount = self.items.count;
    CGFloat itemW = self.sh_width / (subViewCount + 1);
    CGFloat itemH = self.sh_height;
        
    NSInteger index = 0;

    for (UIControl *tabBarView in self.subviews) {
        
        if ([tabBarView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            /*
            if (index == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarView;
            }
             */
            
            if (index == 2) {
                index += 1;
            }
            tabBarView.frame = CGRectMake(index * itemW, 0, itemW, itemH);
            index++;
            [tabBarView addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    self.plusBtn.center = CGPointMake(self.sh_width * 0.5, self.sh_height* 0.5);
    
}

#pragma mark - 监听点击事件
- (void)tabBarBtnClick:(UIControl *)tabBarBtn
{
    if (self.previousClickedTabBarButton == tabBarBtn) {
        [[NSNotificationCenter defaultCenter]postNotificationName:SHTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.previousClickedTabBarButton = tabBarBtn;
}
#pragma mark - Getters
- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:kImageName(@"tabBar_publish_icon") forState:UIControlStateNormal];
        [_plusBtn setImage:kImageName(@"tabBar_publish_click_icon") forState:UIControlStateHighlighted];
        [_plusBtn sizeToFit];
        [self addSubview:_plusBtn];

    }
    return _plusBtn;
}
@end










































