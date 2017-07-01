//
//  SHFourViewController.m
//  SHCode
//
//  Created by ios on 17/3/27.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFourViewController.h"
#import "SHCollectionViewCell.h"
#import "SHFlowLayout.h"


static NSString *const flowLayoutcollectionID = @"flowLayoutcollectionID";

@interface SHFourViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *dataArrM;
@property (nonatomic, strong) SHFlowLayout *layout;


@end

@implementation SHFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionV];
    
    [self setupDataSource];

}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:flowLayoutcollectionID forIndexPath:indexPath];
    SHCollectionModel *model = self.dataArrM[indexPath.item];
    cell.model = model;
    return cell;
}

#pragma mark - dataSource
- (void)setupDataSource
{
    for (NSInteger i = 0; i < 10; i++) {
        SHCollectionModel *model = [[SHCollectionModel alloc] init];
        model.mainStr = kFormat(@"第%ld个", i);
        [self.dataArrM addObject:model];
    }
    
    [self.collectionV reloadData];
}

#pragma mark - Getters

- (UICollectionView *)collectionV
{
    if (!_collectionV) {
        SHFlowLayout *layOut = [[SHFlowLayout alloc] init];
        layOut.itemSize = CGSizeMake(160, 160);
        CGFloat margin = (kScreenW - 160) * 0.5;
        layOut.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        //设置最小行间距
        layOut.minimumLineSpacing = 50;
        
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, kScreenW, 200) collectionViewLayout:layOut];
        _collectionV.backgroundColor = kWhiteColor;
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        _collectionV.showsVerticalScrollIndicator = NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        
        [_collectionV registerClass:[SHCollectionViewCell class] forCellWithReuseIdentifier:flowLayoutcollectionID];
        
    }
    return _collectionV;
}
- (NSMutableArray *)dataArrM
{
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
