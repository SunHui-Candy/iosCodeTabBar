//
//  SHTwoViewController.m
//  SHCode
//
//  Created by ios on 17/3/27.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTwoViewController.h"
#import "SHTitleBtn.h"
#import "SHPopoverViewController.h"
#import "SHPopAnimator.h"
#import "SHPathTwoModel.h"
#import "SHPathTwoCell.h"

@interface SHTwoViewController ()

@property (nonatomic, strong)SHTitleBtn *titleBtn;
@property (nonatomic, strong) SHPopAnimator *popAnimator;

@property (nonatomic, strong) NSMutableArray<SHPathTwoModel *> *viewModelsArrM;


@end

@implementation SHTwoViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (!self.isLogin) {
        return;
    }
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHPathTwoCell class]) bundle:nil] forCellReuseIdentifier:SHPathTwoCellID];
    
    
    
    [self setupNavigationBar];
    [self loadNewStatuses];
    

    
  //  [self setupHeaderView];
    
}



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelsArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHPathTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:SHPathTwoCellID forIndexPath:indexPath];
    cell.viewModel = self.viewModelsArrM[indexPath.row];
   // [self tableView:tableView heightForRowAtIndexPath:indexPath];
    NSLog(@"cellforRow高度,%lf,row:%ld",cell.viewModel.cellHeight,indexPath.row);
    return cell;
    
}


#pragma mark - Private&Public Methods
- (void)setupHeaderView
{
    self.tableView.tableHeaderView = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadNewStatuses];
   }];
    
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)loadNewStatuses
{
    [self loadStatuses:YES];
}

- (void)loadStatuses:(BOOL)isNewData
{
    NSInteger since_id = 0;
    NSInteger max_id = 0;
    
    
    if (isNewData) {
        
        SHPathTwoModel *pathTwoModel = self.viewModelsArrM.firstObject;
        since_id = pathTwoModel.status.mid;
        
    }else {
        SHPathTwoModel *pathTwoModel = self.viewModelsArrM.lastObject;
        max_id = pathTwoModel.status.mid;
        max_id = max_id == 0 ? 0 : (max_id - 1);
    }
    
    [SVProgressHUD show];
    [[SHNetworkTools shareInstance] loadStatusesWithSince_id:since_id max_id:max_id success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"加载微博数据成功,%@",responseObject);
        
        
        NSArray *temArr = [SHPathStatsTwoModel mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
//        NSMutableArray *tempArrM = [NSMutableArray array];

        for (SHPathStatsTwoModel *statusModel in temArr) {
            
            SHPathTwoModel *viewModel = [[SHPathTwoModel alloc] init];
            viewModel.status = statusModel;
            [self.viewModelsArrM addObject:viewModel];
        }
        
        
//        [self.viewModelsArrM addObjectsFromArray:tempArrM];

        [self cacheImages];
        
      //  [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"加载微博数据失败,%@",error);
    }];
}


- (void)cacheImages
{
        
    dispatch_group_t group = dispatch_group_create();
    
    for (SHPathTwoModel *twoModel in self.viewModelsArrM) {
        for (NSURL *picUrl in twoModel.picURLs) {
            dispatch_group_enter(group);
            [[SDWebImageManager sharedManager] downloadImageWithURL:picUrl options:SDWebImageCacheMemoryOnly progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                dispatch_group_leave(group);
            }];
        }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

#pragma mark - 设置导航
- (void)setupNavigationBar
{
    self.navigationItem.titleView = self.titleBtn;
}


#pragma mark - 监听点击事件
- (void)titleBtnClick:(SHTitleBtn *)btn
{
    SHPopoverViewController *popVC = [[SHPopoverViewController alloc]init];
    popVC.modalPresentationStyle = UIModalPresentationCustom;
    popVC.transitioningDelegate = self.popAnimator;
    self.popAnimator.presentedF = CGRectMake(100, SHNavMaxY, 180, 220);
    [self presentViewController:popVC animated:YES completion:nil];
}

#pragma mark - Getters

- (NSMutableArray *)viewModelsArrM
{
    if (!_viewModelsArrM) {
        _viewModelsArrM = [NSMutableArray array];
    }
    return _viewModelsArrM;
}

- (SHPopAnimator *)popAnimator
{
    if (!_popAnimator) {
        _popAnimator = [[SHPopAnimator alloc] initWithCallBack:^(BOOL popPresented) {
            self.titleBtn.selected = popPresented;
        }];
    }
    return _popAnimator;
}

- (SHTitleBtn *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [SHTitleBtn buttonWithType:UIButtonTypeCustom];
        [_titleBtn setTitle:@"syhCode" forState:UIControlStateNormal];
        [_titleBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}

@end














































