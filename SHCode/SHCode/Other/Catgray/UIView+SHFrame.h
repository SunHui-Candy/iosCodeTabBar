//
//  UIView+SHFrame.h
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SHFrame)

@property CGFloat sh_height;
@property CGFloat sh_width;
@property CGFloat sh_x;
@property CGFloat sh_y;
@property CGFloat sh_centerX;
@property CGFloat sh_centerY;

+ (instancetype)sh_viewFromXib;

@end
