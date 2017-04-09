//
//  SHTopicPictureView.m
//  SHCode
//
//  Created by ios on 17/4/6.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTopicPictureView.h"
#import "SHOneChildModel.h"

@interface SHTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end
@implementation SHTopicPictureView

- (void)setChildModel:(SHOneChildModel *)childModel
{
    _childModel = childModel;
    
    [self.picImageV sh_setOriginImage:childModel.image1 thumbnailImage:childModel.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (!image) {
            return ;
        }
        
        if (childModel.isBigPicture) {
            CGFloat imageW = childModel.middleFrame.size.width;
            CGFloat imageH = imageW * childModel.height / childModel.width;
            
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.picImageV.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.picImageV.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }];
    
    self.gifView.hidden = !childModel.is_gif;
    
    if (childModel.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.picImageV.contentMode = UIViewContentModeTop;
        self.picImageV.clipsToBounds = YES;
    }else {
        self.seeBigPictureButton.hidden = YES;
        self.picImageV.contentMode = UIViewContentModeScaleToFill;
        self.picImageV.clipsToBounds = NO;
    }
}

@end
