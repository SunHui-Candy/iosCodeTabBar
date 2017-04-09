//
//  SHLoginRegisterView.m
//  SHCode
//
//  Created by ios on 17/4/8.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHLoginRegisterView.h"


@interface SHLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end
@implementation SHLoginRegisterView

+ (instancetype)loginView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

+ (instancetype)registerView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *image = self.loginRegisterBtn.currentBackgroundImage;
    //让按钮的背景图片不拉伸
   image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];

    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}
@end
