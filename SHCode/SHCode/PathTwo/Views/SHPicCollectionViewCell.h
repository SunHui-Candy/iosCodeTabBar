//
//  SHPicCollectionViewCell.h
//  SHCode
//
//  Created by ios on 17/4/17.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHPicCollectionViewCellID @"SHPicCollectionViewCellID"


@interface SHPicCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;

@property (nonatomic, strong) NSURL *picUrl;

@end
