//
//  SHOneChildModel.h
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHOneChildModel : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;


/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;
/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;


/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;

/** 是否为动图 */
@property (nonatomic, assign) BOOL is_gif;


/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;



@property (nonatomic, assign) CGFloat cellH;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;

/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


@end
