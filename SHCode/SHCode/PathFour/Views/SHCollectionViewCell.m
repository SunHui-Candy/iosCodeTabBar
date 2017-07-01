//
//  SHCollectionViewCell.m
//  SHCode
//
//  Created by ios on 2017/6/28.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHCollectionViewCell.h"

@interface SHCollectionViewCell ()

@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UILabel *mainL;

@end

@implementation SHCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRedColor;
        [self.contentView addSubview:self.bgV];
        [self.contentView addSubview:self.mainL];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [self.mainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgV).offset(10);
    }];
}

- (void)setModel:(SHCollectionModel *)model
{
    _model = model;
    self.mainL.text = model.mainStr;
}

#pragma mark - Getters

- (UILabel *)mainL
{
    if (!_mainL) {
        
        _mainL = [SHCustomControlTool sh_customLabelTextFont:kFontSize(15) textColor:kOrangeColor];
    }
    return _mainL;
}

- (UIView *)bgV
{
    if (!_bgV) {
        _bgV = [SHCustomControlTool sh_customViewBgColor:kBlueColor];
    }
    return _bgV;
}
@end
