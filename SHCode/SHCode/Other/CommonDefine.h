//
//  CommonDefine.h
//  SHCode
//
//  Created by ios on 17/3/29.
//  Copyright © 2017年 ios. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//颜色
#define kSHColor(r,g,b)  [UIColor colorWithRed:(b) / 256.0 green:(g) / 256.0  blue:(b)/ 256.0 alpha:1.0]

#define kSHRandomColor   kSHColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//黑色
#define kBlackColor [UIColor blackColor]
#define kRedColor [UIColor redColor]
#define kWhiteColor [UIColor whiteColor]
#define kClearColor [UIColor clearColor]
#define kBlueColor [UIColor blueColor]
#define kYellowColor [UIColor yellowColor]
#define kOrangeColor [UIColor orangeColor]

//图片
#define kImageName(imageName) [UIImage imageNamed:imageName]

//字体
#define kFontSize(fontSize) [UIFont systemFontOfSize:fontSize]

//格式化字符串
#define kFormat(string, args...)       [NSString stringWithFormat:string, args]


//屏幕宽高
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width



#endif /* CommonDefine_h */
