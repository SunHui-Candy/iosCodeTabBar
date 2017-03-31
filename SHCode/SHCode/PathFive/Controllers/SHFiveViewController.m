//
//  SHFiveViewController.m
//  SHCode
//
//  Created by ios on 17/3/27.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFiveViewController.h"
#import "SHFiveCollectionViewCell.h"
#import "SHFiveModel.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;

#define collectinItemWH (kScreenW - (cols - 1) * margin) / cols

@interface SHFiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectoinView;
@property (nonatomic, strong) NSMutableArray *collecsArrM;
@end

@implementation SHFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SHMarin;
    self.tableView.tableFooterView = self.collectoinView;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SHMarin)];
    [self loadData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collecsArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHFiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SHFiveCollectionViewCellID forIndexPath:indexPath];
    cell.model = self.collecsArrM[indexPath.row];
    //cell.itemL.text = kFormat(@"这个,%ld",indexPath.row);
    cell.backgroundColor = kSHRandomColor;
    return cell;
}

#pragma mark - Private&Public Methods
- (void)loadData
{
    for (NSInteger index = 0; index < 9; index++) {
        SHFiveModel *model = [[SHFiveModel alloc] init];
        model.title = kFormat(@"第%ld", index);
        
        [self.collecsArrM addObject:model];
        
        NSInteger count = self.collecsArrM.count;
        
        //重新计算collection的高度
        NSInteger row = (count - 1) / cols + 1;
        CGFloat collectionH = row * collectinItemWH;
        
        CGRect collectinF = self.collectoinView.frame;
        collectinF.size.height = collectionH;
        self.collectoinView.frame = collectinF;
        
    }
    
    [self soulvData];
    
    self.tableView.tableFooterView = self.collectoinView;
    
    [self.tableView reloadData];
}

//补空白格
- (void)soulvData
{
    NSInteger count = self.collecsArrM.count;

    NSInteger addCount = cols - count % cols;

    if (addCount) {
        for (NSInteger i = 0 ; i < addCount; i++) {
            
            SHFiveModel *model = [[SHFiveModel alloc] init];
            
            [self.collecsArrM addObject:model];
        }
    }
}

#pragma mark - Getters
- (UICollectionView *)collectoinView
{
    if (!_collectoinView) {
        
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.itemSize = CGSizeMake(collectinItemWH, collectinItemWH);
        layOut.minimumLineSpacing = margin;
        layOut.minimumInteritemSpacing = margin;
        
        _collectoinView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 300) collectionViewLayout:layOut];
        _collectoinView.delegate = self;
        _collectoinView.dataSource = self;
        _collectoinView.backgroundColor = kSHRandomColor;
        _collectoinView.scrollEnabled = NO;
       
        [_collectoinView registerNib:[UINib nibWithNibName:NSStringFromClass([SHFiveCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:SHFiveCollectionViewCellID];
        
        
        
    }
    return _collectoinView;
}

- (NSMutableArray *)collecsArrM
{
    if (!_collecsArrM) {
        _collecsArrM = [NSMutableArray array];
    }
    return _collecsArrM;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
