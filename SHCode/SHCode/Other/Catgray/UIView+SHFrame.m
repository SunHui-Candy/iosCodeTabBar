//
//  UIView+SHFrame.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UIView+SHFrame.h"

@implementation UIView (SHFrame)

- (void)setSh_height:(CGFloat)sh_height
{
    CGRect rect = self.frame;
    rect.size.height = sh_height;
    self.frame = rect;
}

- (CGFloat)sh_height
{
    return self.frame.size.height;
}


- (void)setSh_width:(CGFloat)sh_width
{
    CGRect rect = self.frame;
    rect.size.width = sh_width;
    self.frame = rect;
}

- (CGFloat)sh_width
{
    return self.frame.size.width;
}


- (void)setSh_x:(CGFloat)sh_x
{
    CGRect rect = self.frame;
    rect.origin.x = sh_x;
    self.frame = rect;
}

- (CGFloat)sh_x
{
    return self.frame.origin.x;

}


- (void)setSh_y:(CGFloat)sh_y
{
    CGRect rect = self.frame;
    rect.origin.y = sh_y;
    self.frame = rect;

}

- (CGFloat)sh_y
{
    return self.frame.origin.y;
}


- (void)setSh_centerX:(CGFloat)sh_centerX
{
    CGPoint center = self.center;
    center.x = sh_centerX;
    self.center = center;

}
- (CGFloat)sh_centerX
{
    return self.center.x;
}

- (void)setSh_centerY:(CGFloat)sh_centerY
{
    CGPoint center = self.center;
    center.y = sh_centerY;
    self.center = center;
}

- (CGFloat)sh_centerY
{
    return self.center.y;
}
@end
