//
//  SHFlowLayout.m
//  SHCode
//
//  Created by ios on 2017/6/28.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHFlowLayout.h"

@implementation SHFlowLayout

//滚动的时候是否允许刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//给定一段区域,返回这段区域内所有的cell的布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //确定区域:为self.collectionView.bounds
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        //求出数组中的cell距离中心点的距离
        CGFloat deleta = fabs(attr.center.x - self.collectionView.contentOffset.x - self.collectionView.bounds.size.width * 0.5);
        
        //距离中心点越近,缩放越大
        CGFloat scale = 1 - deleta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
        
        attr.transform =  CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}


// 用户收支一松开,就会掉那个用, 确定最终偏移量
// 定位: 距离中心点越近,这个cell最终展示到中心点

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    //确定最终的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, self.collectionView.bounds.size.width, MAXFLOAT);
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    //确定距离中心点最小的距离
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        // 注意: 应该用最终的x, 来获取距离中心点的距离
        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    //移动间距
    targetP.x += minDelta;
    
    if (targetP.x < 0) {
        targetP.x = 0;
    }
    
    return targetP;

}
@end
