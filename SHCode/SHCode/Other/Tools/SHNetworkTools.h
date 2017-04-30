//
//  SHNetworkTools.h
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, SHTopicType) {
    /** 全部 */
    SHTopicTypeAll = 1,
    /** 图片 */
    SHTopicTypePicture = 10,
    /** 段子 */
    SHTopicTypeWord = 29,
    /** 声音 */
    SHTopicTypeVoice = 31,
    /** 视频 */
    SHTopicTypeVideo = 41
    
};


typedef void(^SUCCESS_BLOCK)(id responseObject);
typedef void(^FAIL_BLOCK)(NSError *error);

@interface SHNetworkTools : AFHTTPSessionManager

+ (instancetype)shareInstance;


//仿写百思的首页数据
- (void)loadPathOneBaisiWithType:(SHTopicType)type maxtime:(NSString *)maxtime success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure;

//第二部分加载首页的数据
- (void)loadStatusesWithSince_id:(NSInteger)since_id max_id:(NSInteger)max_id success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure;

//第二部分请求token的数据
- (void)loadAccessToken:(NSString *)code success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure;

//第二部分请求用户的信息
- (void)loadUserInfo:(NSString *)access_token uid:(NSString *)uid success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure;

@end
