//
//  SHFindEmoticon.m
//  SHCode
//
//  Created by ios on 17/4/17.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFindEmoticon.h"

@implementation SHFindEmoticon

static SHFindEmoticon *_shareInstance = nil;

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[super allocWithZone:NULL] init];
    });
    return _shareInstance;
}

- (NSMutableAttributedString *)findAttrStr:(NSString *)statusText font:(UIFont*)font
{
    if ([statusText isEqualToString:@""]) {
        return nil;
    }
    NSString *pattern = @"\\[.*?\\]";
    
   NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
   NSArray *results = [regex matchesInString:statusText options:NSMatchingReportProgress range:NSMakeRange(0, statusText.length)];
    
   NSMutableAttributedString *attrMstr = [[NSMutableAttributedString alloc] initWithString:statusText];
    
    for (NSInteger i = results.count - 1; i >= 0; i--) {
        NSString *result = results[i];
        NSString *chs = [statusText substringWithRange:NSMakeRange(0, result.length)];
        NSString *pngPath = [self findPngPath:chs];
       NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = kImageName(pngPath);
        attachment.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
        NSAttributedString *attrImageStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [attrMstr replaceCharactersInRange:NSMakeRange(0, result.length) withString:(NSString *)attrImageStr];
        
    }
    return attrMstr;
    
}

- (NSString *)findPngPath:(NSString *)chs
{
    
    return @"";
}
@end






































