//
//  SHOneChildTableViewCell.h
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHOneChildModel;

#define SHOneChildTableViewCellID @"SHOneChildTableViewCellID"

@interface SHOneChildTableViewCell : UITableViewCell

@property (nonatomic, strong) SHOneChildModel *childModel;
@end
