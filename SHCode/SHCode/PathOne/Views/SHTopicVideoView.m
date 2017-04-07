//
//  SHTopicVideoView.m
//  SHCode
//
//  Created by ios on 17/4/6.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTopicVideoView.h"
#import "SHOneChildModel.h"

@interface SHTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UILabel *playcountL;
@property (weak, nonatomic) IBOutlet UILabel *videotimeL;

@end

@implementation SHTopicVideoView

- (void)setChildModel:(SHOneChildModel *)childModel
{
    _childModel = childModel;
    [self.picImageV sh_setOriginImage:childModel.image1 thumbnailImage:childModel.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return;
        }
    }];
    
    if (childModel.playcount >= 10000) {
        self.playcountL.text = kFormat(@"%f万播放", childModel.playcount / 10000.0);
    }else {
        self.playcountL.text = kFormat(@"%ld播放", childModel.playcount);
    }
    
    self.videotimeL.text = kFormat(@"%02ld:%02ld", childModel.videotime/60,childModel.videotime%60);
    
    
    
}

@end
