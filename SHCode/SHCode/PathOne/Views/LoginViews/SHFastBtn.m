//
//  SHFastBtn.m
//  SHCode
//
//  Created by ios on 17/4/9.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFastBtn.h"

@implementation SHFastBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //图片位置
    self.imageView.sh_y = 0;
    self.imageView.sh_centerX = self.sh_width * 0.5;
    
    //文字位置
    self.titleLabel.sh_y = self.sh_height - self.titleLabel.sh_height;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.sh_centerX = self.sh_width * 0.5;
    
    
}
@end
