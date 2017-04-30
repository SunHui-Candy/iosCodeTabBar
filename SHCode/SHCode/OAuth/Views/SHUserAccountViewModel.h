//
//  SHUserAccountViewModel.h
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHUserAccount.h"


@interface SHUserAccountViewModel : NSObject

@property (nonatomic, strong) SHUserAccount *account;
@property (nonatomic, assign) BOOL isLogin;

+ (instancetype)shareInstance;

- (NSString *)accountPath;

@end
