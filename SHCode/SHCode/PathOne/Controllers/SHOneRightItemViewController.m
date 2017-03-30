//
//  SHOneRightItemViewController.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOneRightItemViewController.h"

@interface SHOneRightItemViewController ()

@end

@implementation SHOneRightItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end