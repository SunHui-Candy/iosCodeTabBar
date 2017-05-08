//
//  SHTopicVideoView.m
//  SHCode
//
//  Created by ios on 17/4/6.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTopicVideoView.h"
#import "SHOneChildModel.h"
#import "SHSeeBigPicViewController.h"

@interface SHTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UILabel *playcountL;
@property (weak, nonatomic) IBOutlet UILabel *videotimeL;

@end

@implementation SHTopicVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.picImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)];
    [self.picImageV addGestureRecognizer:tapGes];
}

- (void)seeBigPicture
{
    SHSeeBigPicViewController *seeBigVC = [[SHSeeBigPicViewController alloc] init];
    seeBigVC.childModel = self.childModel;
    [self.window.rootViewController presentViewController:seeBigVC animated:YES completion:nil];
}

- (void)setChildModel:(SHOneChildModel *)childModel
{
    _childModel = childModel;
    [self.picImageV sh_setOriginImage:childModel.image1 thumbnailImage:childModel.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return;
        }
    }];
    
    
    
    if (childModel.playcount >= 10000) {
        self.playcountL.text = kFormat(@"%.1f万播放", childModel.playcount / 10000.0);
    }else {
        self.playcountL.text = kFormat(@"%ld播放", childModel.playcount);
    }
    
    self.videotimeL.text = kFormat(@"%02ld:%02ld", childModel.videotime/60,childModel.videotime%60);
    
    
    
}

@end
