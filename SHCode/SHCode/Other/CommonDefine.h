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

//图片
#define kImageName(imageName) [UIImage imageNamed:imageName]

//字体
#define kFontSize(fontSize) [UIFont systemFontOfSize:fontSize]




#endif /* CommonDefine_h */