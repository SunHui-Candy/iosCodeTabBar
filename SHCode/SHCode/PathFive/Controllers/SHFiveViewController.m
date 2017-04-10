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
#import "SHWebViewController.h"
#import "SHSettingTableViewController.h"


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
    
    self.tableView.contentInset = UIEdgeInsetsMake(SHMarin - 35, 0, 0, 0);

    
    [self setupFootView];
    
    [self loadData];
    
    // 设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:kImageName(@"mine-setting-icon") hightImage:kImageName(@"mine-setting-icon-click") target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = settingItem;
    
}
- (void)setting
{
    SHSettingTableViewController *settingVC = [[SHSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
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
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHFiveModel *model = self.collecsArrM[indexPath.row];
    if (![model.url containsString:@"http"]) {
        return;
    }
    
    SHWebViewController *webVc = [[SHWebViewController alloc] init];
    webVc.url = [NSURL URLWithString:model.url];
    [self.navigationController pushViewController:webVc animated:YES];
    
}
#pragma mark - 设置tableView底部视图
- (void)setupFootView
{
    self.tableView.tableFooterView = self.collectoinView;
}

#pragma mark - Private&Public Methods
- (void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [mgr GET:SHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        self.collecsArrM = [SHFiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        [self soulvData];
        
        // 设置collectionView 计算collectionView高度 = rows * itemWH
        // Rows = (count - 1) / cols + 1  3 cols4
        NSInteger count = self.collecsArrM.count;
        //重新计算collection的高度
        NSInteger rows = (count - 1) / cols + 1;
        
        // 设置collectioView高度
        self.collectoinView.sh_height = rows * collectinItemWH;
        
        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectoinView;
        //刷新表格
        [self.collectoinView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//补空白格
- (void)soulvData
{
    NSInteger count = self.collecsArrM.count;

    NSInteger exter = count % cols;

    if (exter) {
        exter = cols - exter;
        for (NSInteger i = 0 ; i < exter; i++) {
            
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
        _collectoinView.backgroundColor = self.tableView.backgroundColor;
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
