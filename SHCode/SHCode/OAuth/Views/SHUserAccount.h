//
//  SHUserAccount.h
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "access_token" = "2.00_5u7IDl8OPNE4f2a11e4cc9ik7aB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2873022483;
 }
 */
@interface SHUserAccount : NSObject

@property (nonatomic, strong) NSString *access_token;
//过期时间-->秒
@property (nonatomic, assign) NSTimeInterval expires_in;

@property (nonatomic, assign) NSInteger remind_in;


@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) NSDate *expires_date;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *avatar_large;


@end
