//
//  SHUserAccount.m
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHUserAccount.h"

@interface SHUserAccount ()<NSCoding>

@end

@implementation SHUserAccount

- (NSDate *)expires_date
{
    
    if (self.expires_in) {
        _expires_date = [NSDate dateWithTimeIntervalSinceNow:self.expires_in];
    }
    return _expires_date;
}

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _expires_date = [aDecoder decodeObjectForKey:@"expires_date"];
        _avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
        _expires_in = [aDecoder decodeIntegerForKey:@"expires_in"];
        _name = [aDecoder decodeObjectForKey:@"name"];
 
    }
    
    return self;
}

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_date forKey:@"expires_date"];
    [aCoder encodeObject:self.avatar_large forKey:@"avatar_large"];
    [aCoder encodeObject:self.name forKey:@"name"];

}
@end
