//
//  UIImageView+SHImageView.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "UIImageView+SHImageView.h"
#import <AFNetworkReachabilityManager.h>

@implementation UIImageView (SHImageView)

- (void)sh_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
    }else {
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        }else if (mgr.isReachableViaWWAN){
            BOOL downloadOriginImage3GOr4G = YES;
            if (downloadOriginImage3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];

            }else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];

            }
        }else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];

            }else {
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
            }
        }
        
    }
}


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
