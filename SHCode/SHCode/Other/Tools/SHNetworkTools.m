//
//  SHNetworkTools.m
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHNetworkTools.h"
#import "SHUserAccountViewModel.h"




@implementation SHNetworkTools

+ (instancetype)shareInstance
{
    static SHNetworkTools * _shareInstace;
    _shareInstace = [SHNetworkTools manager];
    _shareInstace.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
    _shareInstace.requestSerializer.timeoutInterval = 30;
    return _shareInstace;
}

#pragma mark - 请求数据的方式
- (void)MethodType:(NSString *)methodType urlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure
{
    
    if ([methodType isEqualToString:GetMethod]) {
        [self GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else if ([methodType isEqualToString:postMethod]){
        
        [self POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

#pragma mark - 请求数据

//第一部分数据,仿写百思数据
- (void)loadPathOneBaisiWithType:(SHTopicType)type maxtime:(NSString *)maxtime success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure
{
    [self MethodType:GetMethod urlStr:SHCommonURL parameters:@{@"a":@"list",
                                                                 @"c":@"data",
                                                                 @"type":@(type),
                                                                 @"maxtime":maxtime
                                                                 } success:success failure:failure];
}

//第二部分加载首页的数据
- (void)loadStatusesWithSince_id:(NSInteger)since_id max_id:(NSInteger)max_id success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure
{
    
    
    NSString *accessToken = [SHUserAccountViewModel shareInstance].account.access_token;
    
    [self MethodType:GetMethod urlStr:wb_pathTwoHomeData parameters:@{@"access_token":accessToken,
                                                                   @"since_id":@(since_id),
                                                                   @"max_id":@(max_id)
                                                                   } success:success failure:failure];

}

//请求AccessToken
- (void)loadAccessToken:(NSString *)code success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure
{
    [self MethodType:postMethod urlStr:wb_AccessToken parameters:@{
                                                                   @"client_id" : app_key, @"client_secret" : app_secret, @"grant_type" : @"authorization_code", @"redirect_uri" : redirect_uri, @"code" : code
                                                                   } success:success failure:failure];
}

//第二部分请求用户的信息
- (void)loadUserInfo:(NSString *)access_token uid:(NSString *)uid success:(SUCCESS_BLOCK)success failure:(FAIL_BLOCK)failure
{
    [self MethodType:GetMethod urlStr:wb_UserInfo parameters:@{@"access_token" : access_token,
                                                               @"uid" : uid
                                                               } success:success failure:failure];
}
@end

























