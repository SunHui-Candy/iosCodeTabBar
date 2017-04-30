//
//  SHWelcomeViewController.m
//  SHCode
//
//  Created by ios on 17/4/12.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHWelcomeViewController.h"
#import "SHUserAccountViewModel.h"
#import "SHUserAccount.h"
#import "SHTwoViewController.h"
#import "SHCustomTBarController.h"
@interface SHWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewBottomCons;

@end

@implementation SHWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SHUserAccount *account = [SHUserAccountViewModel shareInstance].account;
    [self.iconImageV sh_setCircleImage:account.avatar_large];
    
    self.iconViewBottomCons.constant = kScreenH - 200;
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        SHCustomTBarController *tabBarVC = [[SHCustomTBarController alloc] init];
        tabBarVC.selectedIndex = 1;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
        
    }];
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
