//
//  SHFiveCollectionViewCell.h
//  SHCode
//
//  Created by ios on 17/3/31.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHFiveModel;

#define SHFiveCollectionViewCellID @"SHFiveCollectionViewCellID"

@interface SHFiveCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)SHFiveModel *model;

@end
