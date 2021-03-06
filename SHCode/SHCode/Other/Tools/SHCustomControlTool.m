//
//  SHCustomControlTool.m
//  SHCode
//
//  Created by ios on 17/3/31.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHCustomControlTool.h"

@implementation SHCustomControlTool

+(UIView *)sh_customViewBgColor:(UIColor *)bgColor
{
    UIView *cusView = [[UIView alloc] init];
    cusView.backgroundColor = bgColor;
    return cusView;
}

+ (UILabel *)sh_customLabelTextFont:(UIFont *)textFont textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = textFont;
    
    return label;
}

@end
