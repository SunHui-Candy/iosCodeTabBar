//
//  SHOneViewController.m
//  SHCode
//
//  Created by ios on 17/3/27.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOneViewController.h"
#import "SHOneRightItemViewController.h"
#import "SHChildOneTableViewController.h"
#import "SHChildTwoTableViewController.h"
#import "SHChildThreeTableViewController.h"
#import "SHChildFourTableViewController.h"
#import "SHChildFiveTableViewController.h"

@interface SHOneViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topTitleView;
@property (nonatomic, strong) UIView *topLineV;

@property (nonatomic, strong) UIButton *previousClickTitleBtn;//记录上次点击的按钮
@property (nonatomic, strong) UIScrollView *bgScrollV;

@end

@implementation SHOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWhiteColor;
    
    [self setupChildViewControllers];

    [self setupScrollView];
    
    [self setTopTitleView];
    
    [self addChildVcViewsIntoScrollV:0];
    
}

#pragma mark - UIScrollViewDelegate
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.sh_width;
    
    UIButton *btn = self.topTitleView.subviews[index];
    
    [self dealTitleBtnClick:btn];

}

#pragma mark - 方法点击
- (void)topTitleBtnClick:(UIButton *)btn
{
    
    if (self.previousClickTitleBtn == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHTitleButtonDidRepeatClickNotification object:nil];
    }
    
    [self dealTitleBtnClick:btn];
}

- (void)dealTitleBtnClick:(UIButton *)btn
{
    self.previousClickTitleBtn.selected = NO;
    btn.selected = YES;
    self.previousClickTitleBtn = btn;
    
    NSInteger index = btn.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.topLineV.sh_width = btn.titleLabel.sh_width + SHMarin;
        self.topLineV.sh_centerX = btn.sh_centerX;
        
        self.bgScrollV.contentOffset = CGPointMake(index * self.bgScrollV.sh_width, self.bgScrollV.contentOffset.y);
        
    } completion:^(BOOL finished) {
        [self addChildVcViewsIntoScrollV:index];
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) {
            continue;
        }
        
        UIScrollView *scrollV = (UIScrollView *)childVc.view;
        
        if (![scrollV isKindOfClass:[UIScrollView class]]) {
            continue;
        }
        
        scrollV.scrollsToTop = (i == index);
        
        
    }

}

#pragma mark - Private&Public Methods

- (void)addChildVcViewsIntoScrollV:(NSUInteger)index
{
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) {
        return;
    }
    
    UIView *childView = childVC.view;
    CGFloat scrollerW = self.bgScrollV.sh_width;
    childView.frame = CGRectMake(index * scrollerW, 0, scrollerW, self.bgScrollV.sh_height);
    [self.bgScrollV addSubview:childView];
}

- (void)setupChildViewControllers
{
    [self addChildViewController:[[SHChildOneTableViewController alloc] init]];
    [self addChildViewController:[[SHChildTwoTableViewController alloc] init]];
    [self addChildViewController:[[SHChildThreeTableViewController alloc] init]];
    [self addChildViewController:[[SHChildFourTableViewController alloc] init]];
    [self addChildViewController:[[SHChildFiveTableViewController alloc] init]];
    
}

- (void)setupScrollView
{
    [self.view addSubview:self.bgScrollV];
    
}


- (void)setTopTitleView
{
    [self.view addSubview:self.topTitleView];
    
    [self setupTopBtn];
    [self setupTopTitle];
    
}

- (void)setupTopTitle
{
    UIButton *firstBtn = self.topTitleView.subviews.firstObject;
    
    UIView *topLineV = [SHCustomControlTool sh_customViewBgColor:[firstBtn titleColorForState:UIControlStateSelected]];
    

    topLineV.sh_height = 2;
    topLineV.sh_y = self.topTitleView.sh_height - topLineV.sh_height;

    [firstBtn.titleLabel sizeToFit];

    topLineV.sh_width = firstBtn.titleLabel.sh_width + SHMarin;
    topLineV.sh_centerX = firstBtn.sh_centerX;
    
    [self.topTitleView addSubview:topLineV];
    self.topLineV = topLineV;
    
    //切换按钮的点击状态,默认选中第一个按钮
    firstBtn.selected = YES;
    self.previousClickTitleBtn = firstBtn;
    


}


- (void)setupTopBtn
{
    NSArray *titleA = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    NSInteger titleCount = titleA.count;
    
    CGFloat btnW = self.topTitleView.sh_width / titleCount;
    CGFloat btnH = self.topTitleView.sh_height;
    
    for (NSInteger i = 0; i < titleCount; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        btn.tag = i;
        [btn setTitle:titleA[i] forState:UIControlStateNormal];
        [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:kRedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(topTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = kFontSize(16);
        [self.topTitleView addSubview:btn];
    }
}

- (void)setupNavItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:kImageName(@"MainTagSubIcon") hightImage:kImageName(@"MainTagSubIconClick") target:self action:@selector(rightBarItemClick)];
}

- (void)rightBarItemClick
{
    SHOneRightItemViewController *vc = [[SHOneRightItemViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters
- (UIScrollView *)bgScrollV
{
    if (!_bgScrollV) {
        // 不允许自动修改UIScrollView的内边距
        self.automaticallyAdjustsScrollViewInsets = NO;
        _bgScrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        NSUInteger count = self.childViewControllers.count;
        CGFloat scrollW = _bgScrollV.sh_width;
        _bgScrollV.contentSize = CGSizeMake(count * scrollW, 0);
        _bgScrollV.showsVerticalScrollIndicator = NO;
        _bgScrollV.showsHorizontalScrollIndicator = NO;
        _bgScrollV.pagingEnabled = YES;
        _bgScrollV.delegate = self;
    }
    return _bgScrollV;
}

- (UIView *)topTitleView
{
    if (!_topTitleView) {
        _topTitleView = [SHCustomControlTool sh_customViewBgColor:kWhiteColor];
        _topTitleView.frame = CGRectMake(0, SHNavMaxY, kScreenW, SHTopHeightTitle);
    }
    return _topTitleView;
}


@end
