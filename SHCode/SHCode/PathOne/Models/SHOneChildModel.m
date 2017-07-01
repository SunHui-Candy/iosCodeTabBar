//
//  SHOneChildModel.m
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOneChildModel.h"



@implementation SHOneChildModel

- (CGFloat)cellH
{
    if (_cellH) {
        return _cellH;
    }
    
    _cellH += 55;
    
    CGSize textMaxSize = CGSizeMake(kScreenW - 2 * SHMarin, MAXFLOAT);
    
    _cellH += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFontSize(15)} context:nil].size.height + SHMarin;
    
    if (self.type != SHTopicTypeWord) {
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= kScreenH) {
            middleH = 200;
            self.bigPicture = YES;
        }
        self.middleFrame = CGRectMake(SHMarin, _cellH, middleW, middleH);
        _cellH += middleH + SHMarin;
    }
    
    
    if (self.top_cmt.count) {
        _cellH += 21;
        NSDictionary *cmt = self.top_cmt.firstObject;
        
        NSString *content = cmt[@"content"];
        
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        
        NSString *userName = cmt[@"user"][@"username"];
        NSString *cmtText = kFormat(@"%@ : %@", userName,content);
        _cellH += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kFontSize(15)} context:nil].size.height + SHMarin;
    }
    
    
    
    _cellH += 35 + SHMarin;
    
    
    return _cellH;
}

@end
