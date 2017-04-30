//
//  SHPathTwoModel.h
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHPathStatsTwoModel.h"

@interface SHPathTwoModel : NSObject

@property (nonatomic, assign) CGFloat cellHeight;

// MARK:- 对数据处理的属性
@property (nonatomic, strong) NSString *sourceText;          // 处理来源
@property (nonatomic, strong) NSString *createAtText;          // 处理创建时间
@property (nonatomic, strong) UIImage *verifiedImage;        // 处理用户认证图标
@property (nonatomic, strong) UIImage *vipImage;             // 处理用户会员等级
@property (nonatomic, strong) NSURL *profileURL;             // 处理用户头像的地址
@property (nonatomic, strong) NSMutableArray *picURLs;   // 处理微博配图的数据
@property (nonatomic, strong) SHPathStatsTwoModel *status;

@end
