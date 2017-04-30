//
//  SHPopAnimator.h
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callBack)(BOOL popPresented);

@interface SHPopAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL popPresented;
@property (nonatomic, assign) CGRect presentedF;

@property (nonatomic, copy) callBack callBack;

- (instancetype)initWithCallBack:(callBack)callBack;

@end
