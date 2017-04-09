//
//  SHLoginRegisterViewController.m
//  SHCode
//
//  Created by ios on 17/4/8.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHLoginRegisterViewController.h"
#import "SHLoginRegisterView.h"
#import "SHFastLoginView.h"



@interface SHLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleV;
@property (weak, nonatomic) IBOutlet UIView *bottomV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeadCons;

@end

@implementation SHLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SHLoginRegisterView *loginV = [SHLoginRegisterView loginView];
    [self.middleV addSubview:loginV];
    
    SHLoginRegisterView *registerV = [SHLoginRegisterView registerView];
    [self.middleV addSubview:registerV];
    
    SHFastLoginView *fastLoginV = [SHFastLoginView fastLoginView];
    [self.bottomV addSubview:fastLoginV];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    SHLoginRegisterView *loginV = self.middleV.subviews[0];
    loginV.frame = CGRectMake(0, 0, self.middleV.sh_width * 0.5, self.middleV.sh_height);
    
    SHLoginRegisterView *registerV =  self.middleV.subviews[1];
    registerV.frame = CGRectMake(self.middleV.sh_width * 0.5, 0, self.middleV.sh_width * 0.5, self.middleV.sh_height);
    
    
    SHFastLoginView *fastLoginV = self.bottomV.subviews.firstObject;
    fastLoginV.frame = self.bottomV.bounds;
    
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registBtn:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.middleLeadCons.constant = self.middleLeadCons.constant == 0 ? -self.middleV.sh_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
