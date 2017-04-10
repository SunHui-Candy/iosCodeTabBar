//
//  SHFileTool.h
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFileTool : NSObject

// 自己去计算SDWebImage做的缓存
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

+ (void)removeDirectoryPath:(NSString *)directoryPath;
@end
