//
//  SHSubOneAllTableViewController.m
//  SHCode
//
//  Created by ios on 17/4/7.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHSubOneAllTableViewController.h"
#import "SHOneChildTableViewCell.h"

@interface SHSubOneAllTableViewController ()

@property (nonatomic, strong) NSMutableArray<SHOneChildModel *> *dataSouceArrM;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) UIView *headerV;
@property (nonatomic, strong) UILabel *headerL;

@property (nonatomic, strong) UIView *footerV;
@property (nonatomic, strong) UILabel *footerL;

@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@property (nonatomic, copy) NSString *maxtime;


@end

@implementation SHSubOneAllTableViewController

- (SHTopicType)type
{
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kSHRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(SHTopHeightTitle + SHNavMaxY, 0, SHTabBarH, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHOneChildTableViewCell class]) bundle:nil] forCellReuseIdentifier:SHOneChildTableViewCellID];
    
    [self setupRefresh];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:SHTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:SHTitleButtonDidRepeatClickNotification object:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footerV.hidden = (self.dataSouceArrM.count == 0);
    return self.dataSouceArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHOneChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOneChildTableViewCellID forIndexPath:indexPath];
    cell.childModel = self.dataSouceArrM[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHOneChildModel *childModel = self.dataSouceArrM[indexPath.row];
    return childModel.cellH;
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerV.sh_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerBeginRefreshing];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealHeader];
    [self dealFooter];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - Private&Public Methods
- (void)setupRefresh
{
    [self.tableView addSubview:self.headerV];
    self.headerV.frame = CGRectMake(0, -50, kScreenW, 50);
    [self.headerV addSubview:self.headerL];
    self.headerL.text = @"下拉获取最新数据";
    self.headerL.frame = self.headerV.bounds;
    self.headerL.backgroundColor = kRedColor;
    [self headerBeginRefreshing];
    
    
    self.tableView.tableFooterView = self.footerV;
    self.footerV.frame = CGRectMake(0, 0, kScreenW, 35);
    [self.footerV addSubview:self.footerL];
    self.footerL.text = @"上拉加载更多";
    self.footerL.frame = self.footerV.bounds;
    self.footerL.backgroundColor = kBlueColor;
    
    
}

#pragma mark - 重复点击事件
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) {
        return;
    }
    
    if(self.tableView.scrollsToTop == NO) {
        return;
    }
    
    [self headerBeginRefreshing];
    
    
}

- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - Footer

- (void)dealFooter
{
    if (self.tableView.contentSize.height == 0) {
        return;
    }
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.sh_height;
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) {
        [self footerBeginRefreshing];
    }
}

- (void)footerBeginRefreshing
{
    if (self.isFooterRefreshing) {
        return;
    }
    
    self.footerRefreshing = YES;
    self.footerL.text = @"正在加载更多数据...";
    self.footerL.backgroundColor = kYellowColor;
    [self loadMoreData];
}

- (void)footerEndRefreshing
{
    self.footerRefreshing = NO;
    self.footerL.text = @"上拉可以加载更多";
    self.footerL.backgroundColor = kRedColor;
}

#pragma mark - Header

- (void)dealHeader
{
    if (self.isHeaderRefreshing) {
        return;
    }
    CGFloat offSetY = - (self.tableView.contentInset.top + self.headerV.sh_height);
    if (self.tableView.contentOffset.y <= offSetY) {
        self.headerL.text = @"松开立即刷新";
        self.headerL.backgroundColor = kBlackColor;
    }else {
        self.headerL.text = @"下拉可以刷新";
        self.headerL.backgroundColor = kBlueColor;
    }
}

- (void)headerBeginRefreshing
{
    if (self.isHeaderRefreshing) {
        return;
    }
    self.headerL.text = @"数据获取中...";
    self.headerL.backgroundColor = kYellowColor;
    self.headerRefreshing = YES;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerV.sh_height;
        self.tableView.contentInset = inset;
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    [self loadNewData];
}

- (void)headerEndRefreshing
{
    self.headerRefreshing = NO;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headerV.sh_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - loadData

- (void)loadNewData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.manager GET:SHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSDictionary *dic = responseObject;
        NSLog(@"%@",dic);
        
        self.dataSouceArrM = [SHOneChildModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self headerEndRefreshing];
        
    }];
    
}

- (void)loadMoreData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    [self.manager GET:SHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [SHOneChildModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataSouceArrM addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self footerEndRefreshing];
        
    }];
    
    
}


#pragma mark - Getters

- (UIView *)footerV
{
    if (!_footerV) {
        _footerV = [SHCustomControlTool sh_customViewBgColor:kClearColor];
    }
    return _footerV;
}

- (UILabel *)footerL
{
    if (!_footerL) {
        _footerL = [SHCustomControlTool sh_customLabelTextFont:kFontSize(18) textColor:kWhiteColor];
        _footerL.textAlignment = NSTextAlignmentCenter;
    }
    return _footerL;
}

- (UIView *)headerV
{
    if (!_headerV) {
        _headerV = [SHCustomControlTool sh_customViewBgColor:kClearColor];
    }
    return _headerV;
}

- (UILabel *)headerL
{
    if (!_headerL) {
        _headerL = [SHCustomControlTool sh_customLabelTextFont:kFontSize(18) textColor:kWhiteColor];
        _headerL.textAlignment = NSTextAlignmentCenter;
    }
    return _headerL;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

- (NSMutableArray *)dataSouceArrM
{
    if (!_dataSouceArrM) {
        _dataSouceArrM = [NSMutableArray array];
    }
    return _dataSouceArrM;
}


@end
