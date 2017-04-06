//
//  UIImageView+SHImageView.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UIImageView+SHImageView.h"

@implementation UIImageView (SHImageView)

- (void)sh_setCircleImage:(NSString *)headerUrl
{
    UIImage *placeholder = [UIImage sh_circleImageName:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
        
        self.image = [image sh_circleImage];
    }];
}
@end
