//
//  UIImage+SHImage.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UIImage+SHImage.h"

@implementation UIImage (SHImage)

+ (UIImage *)sh_origanalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)sh_circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (instancetype)sh_circleImageName:(NSString *)name
{
    return [kImageName(name) sh_circleImage];
}
@end
