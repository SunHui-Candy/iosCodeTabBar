//
//  UITextField+SHPlaceholder.m
//  SHCode
//
//  Created by ios on 17/4/8.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UITextField+SHPlaceholder.h"
#import <objc/message.h>

@implementation UITextField (SHPlaceholder)

+ (void)load
{
    Method setplaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setSH_placeholderMethod = class_getInstanceMethod(self, @selector(setSH_Placeholder:));
    method_exchangeImplementations(setplaceholderMethod, setSH_placeholderMethod);
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)setSH_Placeholder:(NSString *)placeholder
{
    [self setSH_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end

