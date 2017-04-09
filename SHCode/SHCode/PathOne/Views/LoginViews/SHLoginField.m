//
//  SHLoginField.m
//  SHCode
//
//  Created by ios on 17/4/8.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHLoginField.h"
#import "UITextField+SHPlaceholder.h"


/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候,占位文字颜色变成白色
 */


@implementation SHLoginField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = kWhiteColor;
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = kRedColor;
}

- (void)textBegin
{
    self.placeholderColor = kWhiteColor;

}

- (void)textEnd
{
    self.placeholderColor = kRedColor;

}
@end
