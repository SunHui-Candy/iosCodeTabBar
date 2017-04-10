//
//  SHSettingTableViewController.m
//  SHCode
//
//  Created by ios on 17/4/9.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHSettingTableViewController.h"
#import "SHFileTool.h"
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SHSettingTableViewController ()

@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation SHSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸..."];
    [SHFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self sizeStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SHFileTool removeDirectoryPath:CachePath];
    self.totalSize = 0;
    [self.tableView reloadData];
}

- (NSString *)sizeStr
{
    NSString *sizeStr = @"清除缓存";
    if (self.totalSize > 1000 * 1000) {
        //MB
        CGFloat sizeF = self.totalSize / 1000.0 / 1000.0;
        sizeStr = kFormat(@"%@(%.1fMB)", sizeStr,sizeF);
    }else if (self.totalSize > 1000) {
        //KB
        CGFloat sizeF = self.totalSize / 1000.0;
        sizeStr = kFormat(@"%@(%.1fKB)", sizeStr,sizeF);

    }else if (self.totalSize > 0) {
        //B
        sizeStr = kFormat(@"%@(%.ldB)", sizeStr,self.totalSize);

    }
    return sizeStr;
}
@end












