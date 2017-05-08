//
//  NSString+SHEmptyStr.m
//  SHCode
//
//  Created by ios on 17/5/3.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "NSString+SHEmptyStr.h"

@implementation NSString (SHEmptyStr)

- (BOOL) isBlankString:(NSString *)string {
    NSLog(@"传入的值,,%@",string);
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
