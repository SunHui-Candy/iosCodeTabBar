//
//  SHOneChildTableViewCell.m
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOneChildTableViewCell.h"
#import "SHOneChildModel.h"
@interface SHOneChildTableViewCell ()
// 控件的命名 -> 功能 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

@end
@implementation SHOneChildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setChildModel:(SHOneChildModel *)childModel
{
    _childModel = childModel;
    
    [self.profileImageView sh_setCircleImage:childModel.profile_image];
    self.nameLabel.text = childModel.name;
    self.passtimeLabel.text = childModel.passtime;
    self.text_label.text = childModel.text;
    
    [self setupBtnTitle:self.dingButton number:childModel.ding placeholderStr:@"顶"];
    [self setupBtnTitle:self.caiButton number:childModel.cai placeholderStr:@"踩"];
    [self setupBtnTitle:self.repostButton number:childModel.repost placeholderStr:@"分享"];
    [self setupBtnTitle:self.commentButton number:childModel.comment placeholderStr:@"评论"];
    
    
    
    if (childModel.top_cmt.count) {
        self.topCmtView.hidden = NO;
        NSDictionary *cmt = childModel.top_cmt.firstObject;
        
        NSString *content = cmt[@"content"];
        
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        
        NSString *userName = cmt[@"user"][@"username"];
        self.topCmtLabel.text = kFormat(@"%@ : %@", userName,content);
        
    }else {
        self.topCmtView.hidden = YES;
    }


}


- (void)setupBtnTitle:(UIButton *)btn number:(NSInteger)number placeholderStr:(NSString *)placeholderStr
{
    if (number > 10000) {
        [btn setTitle:kFormat(@"%.1f万",number / 10000.0) forState:UIControlStateNormal];
    }else if(number > 0){
        [btn setTitle:kFormat(@"%ld",number) forState:UIControlStateNormal];
    }else {
        [btn setTitle:placeholderStr forState:UIControlStateNormal];
    }

}
- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= SHMarin;
    [super setFrame:frame];
}

@end


















































