//
//  SHTitleBtn.m
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTitleBtn.h"

@implementation SHTitleBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:kImageName(@"navigationbar_arrow_down") forState:UIControlStateNormal];
        [self setImage:kImageName(@"navigationbar_arrow_up") forState:UIControlStateSelected];
        [self setTitleColor:kBlackColor forState:UIControlStateNormal];
        [self sizeToFit];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.sh_x = 0;
    self.imageView.sh_x = self.titleLabel.sh_width + 5;
}

@end
