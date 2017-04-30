//
//  SHPicCollectionView.m
//  SHCode
//
//  Created by ios on 17/4/17.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPicCollectionView.h"
#import "SHPicCollectionViewCell.h"


@interface SHPicCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation SHPicCollectionView


- (void)setPicUrls:(NSArray *)picUrls
{
    _picUrls = picUrls;
    NSLog(@"设置刷新,,%@",picUrls);
    [self reloadData];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([SHPicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:SHPicCollectionViewCellID];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"设置刷新数据啊啊啊,,%@",self.picUrls);
    return self.picUrls.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SHPicCollectionViewCellID forIndexPath:indexPath];
    cell.picUrl = self.picUrls[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end

