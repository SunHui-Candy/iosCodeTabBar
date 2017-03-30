//
//  UIBarButtonItem+SHBarItem.h
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SHBarItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)imageName hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)imageName hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
