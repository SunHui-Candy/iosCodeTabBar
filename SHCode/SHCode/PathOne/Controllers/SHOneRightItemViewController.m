//
//  SHOneRightItemViewController.m
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHOneRightItemViewController.h"
#import "SHLoginRegisterViewController.h"

@interface SHOneRightItemViewController ()

@end

@implementation SHOneRightItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
}

- (IBAction)loginBtn:(id)sender {
    
    SHLoginRegisterViewController *loginRegisterVc = [[SHLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVc animated:YES completion:nil];
    
    
}


- (void)setupNavItem
{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:kImageName(@"MainTagSubIcon") hightImage:kImageName(@"MainTagSubIconClick") target:self action:@selector(rightBarItemClick)];
    self.navigationItem.title = @"我的关注";
    
}


- (void)rightBarItemClick
{

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
