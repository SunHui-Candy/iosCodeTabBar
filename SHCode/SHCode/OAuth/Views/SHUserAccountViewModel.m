//
//  SHUserAccountViewModel.m
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHUserAccountViewModel.h"
#import "SHUserAccount.h"

@interface SHUserAccountViewModel ()

@property (nonatomic, strong) NSString *accountPath;
@end


@implementation SHUserAccountViewModel

static SHUserAccountViewModel *_shareInstance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[super allocWithZone:NULL] init];
        
    });
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [SHUserAccountViewModel shareInstance];
}


- (NSString *)accountPath
{
       _accountPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        return [_accountPath stringByAppendingPathComponent:@"account.plist"];
    
}

- (BOOL)isLogin
{
    if (self.account == nil) {
        return NO;
    }
    
    NSDate *expiresDate = self.account.expires_date;
    NSLog(@"是否登录过的,%@,%@,%@",expiresDate,self.account,self.accountPath);

    return [expiresDate compare:[NSDate date]] == NSOrderedDescending;
    
}

- (instancetype)init
{
    if (self = [super init]) {

        self.account = [NSKeyedUnarchiver unarchiveObjectWithFile:self.accountPath];
        NSLog(@"是否调动%@",self.account);

    }
    return self;
}
@end
