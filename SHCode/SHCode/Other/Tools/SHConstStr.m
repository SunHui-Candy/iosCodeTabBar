//
//  SHConstStr.m
//  SHCode
//
//  Created by ios on 17/3/30.
//  Copyright © 2017年 ios. All rights reserved.
//
#import <UIKit/UIKit.h>

/* 间距 */
CGFloat const SHMarin = 10;

/* 首页顶部高度 */
CGFloat const SHTopHeightTitle = 35;

/** 导航栏的最大Y值 */
CGFloat const SHNavMaxY = 64;


/** UITabBar的高度 */
CGFloat const SHTabBarH = 49;

/** 统一的一个请求路径 */
NSString  * const SHCommonURL = @"http://api.budejie.com/api/api_open.php";

/** TabBarButton被重复点击的通知 */
NSString  * const SHTabBarButtonDidRepeatClickNotification = @"SHTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString  * const SHTitleButtonDidRepeatClickNotification = @"SHTitleButtonDidRepeatClickNotification";

/** get请求 */
NSString  * const GetMethod = @"GET";

/** post请求 */
NSString  * const postMethod = @"POST";


/** 第二部分的首页请求路径请求 */
NSString  * const wb_pathTwoHomeData = @"https://api.weibo.com/2/statuses/home_timeline.json";

NSString  * const app_key = @"3860254153";
NSString  * const app_secret = @"7a27b92f84b480f1b1a95c44eaf8a0a3";
NSString  * const redirect_uri = @"http://www.baidu.com";

//获取微博的token的地址
NSString  * const wb_AccessToken = @"https://api.weibo.com/oauth2/access_token";

//获取微博的用户信息的地址
NSString  * const wb_UserInfo = @"https://api.weibo.com/2/users/show.json";


/*
 
 NSString  * const app_key = @"3467343333";
 NSString  * const app_secret = @"99cffaeff85c7e8e18a95913de1479d7";
 NSString  * const redirect_uri = @"http://www.520it.com";


 */






