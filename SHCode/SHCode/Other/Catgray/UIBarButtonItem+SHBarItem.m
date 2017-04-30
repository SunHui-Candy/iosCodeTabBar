//
//  UIBarButtonItem+SHBarItem.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UIBarButtonItem+SHBarItem.h"

@implementation UIBarButtonItem (SHBarItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)imageName hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action
{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imageName forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnBgView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnBgView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)imageName selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imageName forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnBgView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnBgView];
}

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)imageName hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:imageName forState:UIControlStateNormal];
    [backBtn setImage:hightImage forState:UIControlStateHighlighted];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [backBtn setTitleColor:kRedColor forState:UIControlStateHighlighted];
    
    [backBtn sizeToFit];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:backBtn.bounds];
    [btnBgView addSubview:backBtn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnBgView];

}


@end
