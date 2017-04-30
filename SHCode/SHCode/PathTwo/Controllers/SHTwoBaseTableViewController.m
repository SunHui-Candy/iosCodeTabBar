//
//  SHTwoBaseTableViewController.m
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHTwoBaseTableViewController.h"
#import "SHVisitorView.h"
#import "SHOAuthViewController.h"
#import "SHBaseNavViewController.h"


@interface SHTwoBaseTableViewController ()

@property (nonatomic, strong) SHVisitorView *visitorV;
@end

@implementation SHTwoBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)loadView
{
    self.isLogin = [SHUserAccountViewModel shareInstance].isLogin;
    self.isLogin ? [super loadView]:[self setupVisitorView];
    
}

- (void)setupVisitorView
{
    self.view = self.visitorV;
    
    [self.visitorV.registBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
     [self.visitorV.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)registerBtnClick
{
    NSLog(@"注册");
}

- (void)loginBtnClick
{
    SHOAuthViewController *oauthVC = [[SHOAuthViewController alloc] init];
    SHBaseNavViewController *nav = [[SHBaseNavViewController alloc] initWithRootViewController:oauthVC];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - Getters
- (SHVisitorView *)visitorV
{
    if (!_visitorV) {
        _visitorV = [SHVisitorView visitorView];
    }
    return _visitorV;
}
@end
