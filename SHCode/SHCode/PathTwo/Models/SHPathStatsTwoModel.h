//
//  SHPathOneStatusModel.h
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHPathTwoUserModel.h"

@interface SHPathStatsTwoModel : NSObject
 
@property (nonatomic, strong) NSString *created_at;                // 微博创建时间
@property (nonatomic, strong) NSString *source;                    // 微博来源
@property (nonatomic, strong) NSString *text;                      // 微博的正文
@property (nonatomic, assign) NSInteger mid;                       // 微博的ID
@property (nonatomic, strong) SHPathTwoUserModel *user;                        // 微博对应的用户
@property (nonatomic, strong) NSArray *pic_urls; // 微博的配图
@property (nonatomic, strong) SHPathStatsTwoModel *retweeted_status; // 微博对应的转发的微博



@end
