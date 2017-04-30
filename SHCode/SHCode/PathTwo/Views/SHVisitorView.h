//
//  SHVisitorView.h
//  SHCode
//
//  Created by ios on 17/4/11.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHVisitorView : UIView
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

+ (instancetype)visitorView;

@end
