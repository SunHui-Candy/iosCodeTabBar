//
//  SHCustomTBarController.m
//  SHCode
//
//  Created by ios on 17/3/27.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHCustomTBarController.h"
#import "SHBaseNavViewController.h"
#import "SHOneViewController.h"
#import "SHTwoViewController.h"
#import "SHThreeViewController.h"
#import "SHFourViewController.h"
#import "SHFiveViewController.h"
#import "SHTabBar.h"



@interface SHCustomTBarController ()

@end

@implementation SHCustomTBarController

#pragma mark - LifeCycle

+ (void)load
{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *normalTitleDic = [NSMutableDictionary dictionary];
    normalTitleDic[NSFontAttributeName] = kFontSize(13);
    [item setTitleTextAttributes:normalTitleDic forState:UIControlStateNormal];
    
    NSMutableDictionary *selTitleDic = [NSMutableDictionary dictionary];
    selTitleDic[NSForegroundColorAttributeName] = kBlackColor;
    [item setTitleTextAttributes:selTitleDic forState:UIControlStateSelected];

    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sh_setupChildViewControllers];
   
    [self sh_setupMiddleItem];
    
}

- (void)sh_setupMiddleItem
{
    SHTabBar *tabBar = [[SHTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - Public & Public Mthods
- (void)sh_setupChildViewControllers
{
    NSArray *barTitle = @[@"懿",@"贰",@"肆",@"伍"];
    
    NSArray *barImageName = @[@"tabBar_essence_icon",@"tabBar_friendTrends_icon",@"tabBar_new_icon",@"tabBar_me_icon"];
    
    NSArray *barSelImageName = @[@"tabBar_essence_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_new_click_icon",@"tabBar_me_click_icon"];
    
    NSArray *childViewControllers = @[@"SHOneViewController",@"SHTwoViewController",@"SHFourViewController",@"SHFiveViewController"];
    
    
    
    for (NSInteger i = 0; i < barTitle.count; i++) {
        
        UIViewController *childVC;
        if (i == 3) {
            
            UIStoryboard *meStor = [UIStoryboard storyboardWithName:NSStringFromClass([SHFiveViewController class]) bundle:nil];
            
            childVC  = [meStor instantiateInitialViewController];
            


        }else {
            
            childVC = [[NSClassFromString(childViewControllers[i]) alloc] init];

        }
        
        [self setupTitleViewController:childVC title:barTitle[i] imageName:barImageName[i] seleImageName:barSelImageName[i]];
        

    }
    
    
    
    
}

- (void)setupTitleViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName seleImageName:(NSString *)seleImageName
{

    SHBaseNavViewController *baseNavVC = [[SHBaseNavViewController alloc] initWithRootViewController:childVC];
    baseNavVC.tabBarItem.title = title;
    baseNavVC.tabBarItem.image = kImageName(imageName);
    baseNavVC.tabBarItem.selectedImage = [UIImage sh_origanalImageName:seleImageName];
    
    [self addChildViewController:baseNavVC];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











































