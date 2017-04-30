//
//  SHConstStr.h
//  SHCode
//
//  Created by ios on 17/3/30.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 间距 */
UIKIT_EXTERN CGFloat const SHMarin;

/* 首页顶部高度 */
UIKIT_EXTERN CGFloat const SHTopHeightTitle;

/** 导航栏的最大Y值 */
UIKIT_EXTERN CGFloat const SHNavMaxY;

/** UITabBar的高度 */
UIKIT_EXTERN CGFloat const SHTabBarH;

/** 统一的一个请求路径 */
UIKIT_EXTERN NSString  * const SHCommonURL;

/** TabBarButton被重复点击的通知 */
UIKIT_EXTERN NSString  * const SHTabBarButtonDidRepeatClickNotification;

/** TitleButton被重复点击的通知 */
UIKIT_EXTERN NSString  * const SHTitleButtonDidRepeatClickNotification;

/** get请求 */
UIKIT_EXTERN NSString  * const GetMethod;

/** post请求 */
UIKIT_EXTERN NSString  * const postMethod;

/** 第二部分的首页请求路径请求 */
UIKIT_EXTERN NSString  * const wb_pathTwoHomeData;

UIKIT_EXTERN NSString  * const app_key;
UIKIT_EXTERN NSString  * const redirect_uri;
UIKIT_EXTERN NSString  * const app_secret;
//获取微博的token的地址
UIKIT_EXTERN NSString  * const wb_AccessToken;
//获取微博的用户信息的地址
UIKIT_EXTERN NSString  * const wb_UserInfo;
