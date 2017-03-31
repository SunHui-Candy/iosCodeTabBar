//
//  SHFiveCollectionViewCell.m
//  SHCode
//
//  Created by ios on 17/3/31.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFiveCollectionViewCell.h"
#import "SHFiveModel.h"

@interface SHFiveCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *itemL;


@end


@implementation SHFiveCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}



- (void)setModel:(SHFiveModel *)model
{
    _model = model;
    self.itemL.text = model.title;
    
}
@end
