//
//  SHPathTwoModel.m
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPathTwoModel.h"

@implementation SHPathTwoModel

- (void)setStatus:(SHPathStatsTwoModel *)status
{
    _status = status;
    NSString *source = status.source;
    if (![source isEqualToString:@""]) {
        NSUInteger startIndex = [source rangeOfString:@">"].location + 1;
        NSUInteger length = [source rangeOfString:@"</"].location - startIndex;
        self.sourceText = [source substringWithRange:NSMakeRange(startIndex, length)];
        
    }
    
    NSString *createAt = status.created_at;
    self.createAtText = [NSDate createDateStr:createAt];
    
   NSInteger verfiedType = status.user.verified_type;
    switch (verfiedType) {
        case 0:
        {
            self.verifiedImage = kImageName(@"avatar_vip");
        }
            break;
        case 2:
        {
            self.verifiedImage = kImageName(@"avatar_enterprise_vip");

        }
            break;
        case 220:
        {
            self.verifiedImage = kImageName(@"avatar_grassroot");

        }
            break;

        default:
            self.verifiedImage = kImageName(@"");

            break;
    }
    
   NSInteger mbrank = status.user.mbrank;
    if (mbrank > 0 && mbrank <= 6) {
        self.vipImage = kImageName(kFormat(@"common_icon_membership_level%ld", mbrank));
        
    }
    
    //用户头像
    self.profileURL = [NSURL URLWithString:status.user.profile_image_url];
    
    //处理配图数据
    NSArray *picUrlDicts = status.pic_urls.count != 0 ? status.pic_urls : status.retweeted_status.pic_urls;
        
    if (picUrlDicts.count != 0) {
        for (NSDictionary *picUrlDict in picUrlDicts) {
            NSString *picUrlStr = picUrlDict[@"thumbnail_pic"];
            if ([picUrlStr isEqualToString:@""]) {
                continue;
            }
            [self.picURLs addObject:[NSURL URLWithString:picUrlStr]];
        }
    }
 
    
    
    
}

- (NSMutableArray *)picURLs
{
    if (!_picURLs) {
        _picURLs = [NSMutableArray array];
    }
    return _picURLs;
}
@end
