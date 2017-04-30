//
//  SHPathTwoUserModel.h
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHPathTwoUserModel : NSObject

@property (nonatomic, strong) NSString *profile_image_url;         // 用户的头像
@property (nonatomic, strong) NSString *screen_name;               // 用户的昵称
@property (nonatomic, assign) NSInteger verified_type ;            // 用户的认证类型
@property (nonatomic, assign) NSInteger mbrank;// 用户的会员等级

@end
