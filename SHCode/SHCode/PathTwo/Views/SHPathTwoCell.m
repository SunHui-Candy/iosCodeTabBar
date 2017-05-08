//
//  SHPathTwoCell.m
//  SHCode
//
//  Created by ios on 17/4/14.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPathTwoCell.h"
#import "SHPicCollectionView.h"

#define edgeMargin 15
#define itemMargin 10

@interface SHPathTwoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;// 2.设置头像
@property (weak, nonatomic) IBOutlet UIImageView *verifiedView;// 3.设置认证的图标
@property (weak, nonatomic) IBOutlet UILabel *screenNameL;// 4.昵称
@property (weak, nonatomic) IBOutlet UIImageView *vipView;// 5.会员图标
@property (weak, nonatomic) IBOutlet UILabel *timeL;// 6.设置时间的Label
@property (weak, nonatomic) IBOutlet UILabel *sourceL;// 7.设置来源
@property (weak, nonatomic) IBOutlet UILabel *contentL;// 7.设置微博正文
@property (weak, nonatomic) IBOutlet SHPicCollectionView *picView;
@property (weak, nonatomic) IBOutlet UILabel *retweetedContentL;// 1.设置转发微博的正文
@property (weak, nonatomic) IBOutlet UIView *retweetedBgView;// 2.设置背景显示
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLWCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewWCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewHCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewBottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedContentLabelTopCons;

@end

@implementation SHPathTwoCell
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

- (void)setViewModel:(SHPathTwoModel *)viewModel
{
    _viewModel = viewModel;
    
    [self.iconImageV sh_setCircleImage:[viewModel.profileURL absoluteString]];
    
//    [self.iconImageV sd_setImageWithURL:viewModel.profileURL placeholderImage:kImageName(@"avatar_default_small")];
    
    self.verifiedView.image = viewModel.verifiedImage;
    self.screenNameL.text = viewModel.status.user.screen_name;
    self.vipView.image = viewModel.vipImage;
    self.timeL.text = viewModel.createAtText;
    self.contentL.text = viewModel.status.text;
    NSString *sourceText = viewModel.sourceText;
    NSLog(@"来说,,%@",sourceText);
    if (![self isBlankString:sourceText]) {
        self.sourceL.text = kFormat(@"来自%@", sourceText);
    }else {
        self.sourceL.text = @"";
    }
    
    self.screenNameL.textColor = viewModel.vipImage == nil ? kBlackColor : kRedColor;
    

    CGSize picViewSize = [self calculatePicViewSizecalculatePicViewSize:viewModel.picURLs.count];
    self.picViewWCons.constant = picViewSize.width;
    self.picViewHCons.constant = picViewSize.height;
    
    self.picView.picUrls = viewModel.picURLs;

    if (viewModel.status.retweeted_status != nil) {
        NSString *screenName = viewModel.status.retweeted_status.user.screen_name;
        
        NSString *retweetedText = kFormat(@"@%@: %@", screenName,viewModel.status.retweeted_status.text);
        
        self.retweetedContentL.text = retweetedText;
        
        
        self.retweetedContentLabelTopCons.constant = 15;
        self.retweetedBgView.hidden = NO;
        
    }else {
        
        self.retweetedContentL.text = @"";
        self.retweetedBgView.hidden = YES;
        self.retweetedContentLabelTopCons.constant = 0;
        
    }
    
}

- (CGSize)calculatePicViewSizecalculatePicViewSize:(NSInteger)count
{
    if (count == 0) {
        self.picViewBottomCons.constant = 0;
        return CGSizeZero;
    }
    
    self.picViewBottomCons.constant = 10;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.picView.collectionViewLayout;
    
    if (count == 1) {
        NSString *urlStr = [self.viewModel.picURLs.lastObject absoluteString];
        UIImage *image = [[[SDWebImageManager sharedManager] imageCache]imageFromDiskCacheForKey:urlStr];
        layout.itemSize = CGSizeMake(image.size.width * 2, image.size.height * 2);
        return CGSizeMake(image.size.width * 2, image.size.height * 2);
    }
    
    
    CGFloat imageWH = (kScreenW - 2 * edgeMargin - 2 * itemMargin )/3;
    
    layout.itemSize = CGSizeMake(imageWH, imageWH);
    
    if (count == 4) {
        CGFloat picViewWH = imageWH * 2 + itemMargin + 1;
        return CGSizeMake(picViewWH, picViewWH);
    }
    
    NSInteger rows = ( count - 1 ) / 3 + 1;
    CGFloat picViewH = rows * imageWH + (rows - 1) * itemMargin;
    CGFloat picViewW = kScreenW - 2 * edgeMargin;
    return CGSizeMake(picViewW, picViewH);
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLWCons.constant = kScreenW - 2 *edgeMargin;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
























































