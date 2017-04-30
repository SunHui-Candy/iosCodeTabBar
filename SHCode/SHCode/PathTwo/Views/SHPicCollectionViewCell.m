//
//  SHPicCollectionViewCell.m
//  SHCode
//
//  Created by ios on 17/4/17.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPicCollectionViewCell.h"

@implementation SHPicCollectionViewCell
- (void)setPicUrl:(NSURL *)picUrl
{
    _picUrl = picUrl;
    [self.iconImageV sd_setImageWithURL:picUrl placeholderImage:kImageName(@"empty_picture")];

}

@end
