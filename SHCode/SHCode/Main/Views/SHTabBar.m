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

@end

@implementation SHTabBar


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger subViewCount = self.items.count;
    CGFloat itemW = self.sh_width / (subViewCount + 1);
    CGFloat itemH = self.sh_height;
        
    NSInteger index = 0;
    
    for (UIView *tabBarView in self.subviews) {
        
        if ([tabBarView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (index == 2) {
                index += 1;
            }
            tabBarView.frame = CGRectMake(index * itemW, 0, itemW, itemH);
            index++;
        }
    }
    
    self.plusBtn.center = CGPointMake(self.sh_width * 0.5, self.sh_height* 0.5);
    
}


#pragma mark - Private&Public Methods
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










































