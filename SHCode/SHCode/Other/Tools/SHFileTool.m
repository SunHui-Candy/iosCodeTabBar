//
//  SHFileTool.m
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFileTool.h"

@implementation SHFileTool

+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileMgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *excep = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excep raise];
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [fileMgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [fileMgr removeItemAtPath:filePath error:nil];
    }
}

+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger))completion
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileMgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger totalSize = 0;
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [fileMgr subpathsAtPath:directoryPath];
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) {
                continue;
            }
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [fileMgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) {
                continue;
            }
            
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [fileMgr attributesOfItemAtPath:filePath error:nil];
            NSInteger fileSize = [attr fileSize];
            totalSize += fileSize;
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
        
    });
    
}
@end
