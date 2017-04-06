//
//  SHOneChildModel.h
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SHTopicType) {
    /** 全部 */
    SHTopicTypeAll = 1,
    /** 图片 */
    SHTopicTypePicture = 10,
    /** 段子 */
    SHTopicTypeWord = 29,
    /** 声音 */
    SHTopicTypeVoice = 31,
    /** 视频 */
    SHTopicTypeVideo = 41

};

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


@property (nonatomic, assign) CGFloat cellH;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;

@end
