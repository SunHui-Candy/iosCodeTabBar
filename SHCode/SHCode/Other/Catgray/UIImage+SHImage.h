//
//  UIImage+SHImage.h
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SHImage)

/*
 返回不被渲染的图片
 */
+ (UIImage *)sh_origanalImageName:(NSString *)imageName;

@end
