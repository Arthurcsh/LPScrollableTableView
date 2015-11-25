//
//  LPCollectionViewPlainLayout.m
//  LPScrollableTableView
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPCollectionViewPlainLayout.h"

@implementation LPCollectionViewPlainLayout {
    __weak id<LPBidirectionalCollectionLayoutDelegate> _delegate;
    UIEdgeInsets _maxInsets;
    CGFloat _maxRowsWidth;
    CGFloat _maxColumnHeight;
    NSDictionary *_layoutInfo;
}

#pragma mrak - UICollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    _delegate = (id<LPBidirectionalCollectionLayoutDelegate>)self.collectionView.delegate;
    
    _maxInsets = [self maxInsets];
    _maxRowsWidth = [self maxRowWidth];
    _maxColumnHeight = [self maxColumnHeight];
    
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    CGFloat originY = 0;
    CGFloat floatingItemOriginX = self.collectionView.contentOffset.x;
    CGFloat floatingItemOriginY = self.collectionView.contentOffset.y;
    BOOL sectionIsFloating = NO;
    BOOL itemIsFloating = NO;
    
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
        
        UIEdgeInsets itemInsets = UIEdgeInsetsZero;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            itemInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            originY += itemInsets.top;
        }
        
        CGFloat height = 0;
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        CGFloat originX = itemInsets.left;
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:shouldFloatSectionAtIndex:)]) {
            sectionIsFloating = [_delegate collectionView:self.collectionView layout:self shouldFloatSectionAtIndex:section];
        }
        for (NSInteger item = 0; item < itemCount; item++) {
            if ([_delegate respondsToSelector:@selector(collectionView:layout:shouldFloatItemAtIndex:)]) {
                itemIsFloating = [_delegate collectionView:self.collectionView layout:self shouldFloatItemAtIndex:item];
            }
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGSize itemSize = CGSizeZero;
            if ([_delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                itemSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                
                float selectedOriginX = originX;
                float selectedOriginY = originY;
                if (sectionIsFloating) {
                    selectedOriginY = floatingItemOriginY;
                    itemAttributes.zIndex = (NSInteger)1994;
                }
                if (itemIsFloating) {
                    selectedOriginX = floatingItemOriginX;
                    if (sectionIsFloating) {
                        itemAttributes.zIndex = (NSInteger)1994+1992;
                    } else {
                        itemAttributes.zIndex = (NSInteger)1992;
                    }
                }
                
                itemAttributes.frame = CGRectMake(selectedOriginX, selectedOriginY, itemSize.width, itemSize.height);
            }
            cellLayoutInfo[indexPath] = itemAttributes;
            
            CGFloat interItemSpacingX = 0;
            if ([_delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
                interItemSpacingX = [_delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
            }
            
            originX += floorf(itemSize.width + interItemSpacingX);
            height = height > itemSize.height ? height : itemSize.height;
        }
        
        CGFloat interItemSpacingY = 0;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
            interItemSpacingY = [_delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
        }
        
        originY += floor(height + interItemSpacingY);
        if (sectionIsFloating) {
            floatingItemOriginY += height;
        }
    }
    
    _layoutInfo = cellLayoutInfo;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = _maxInsets.left + _maxRowsWidth + _maxInsets.right;
    CGFloat height = _maxInsets.top + _maxColumnHeight + _maxInsets.bottom;
    return CGSizeMake(width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_layoutInfo.count];
    
    [_layoutInfo enumerateKeysAndObjectsUsingBlock:
     ^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _layoutInfo[indexPath];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

#pragma mrak - Action

- (CGFloat)maxRowWidth {
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    CGFloat maxRowWidth = 0;
    for (int i = 0; i < sectionCount; i++) {
        CGFloat maxWidth = 0;
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            
            if ([_delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                CGSize itemSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                maxWidth += itemSize.width ;
            }
        }
        
        CGFloat interItemSpace = 0;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
            CGFloat interItemSpacingX = [_delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:i];
            UIEdgeInsets itemInsets = UIEdgeInsetsZero;
            if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                itemInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i];
            }
            
            interItemSpace = interItemSpacingX * (itemCount - 1);
        }
        maxWidth += interItemSpace;
        maxRowWidth = maxWidth > maxRowWidth ? maxWidth : maxRowWidth;
    }
    
    return maxRowWidth;
}

- (CGFloat)maxColumnHeight {
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    CGFloat maxHeight = 0;
    for (int i = 0; i < sectionCount; i++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        CGFloat maxRowHeight = 0;
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            if ([_delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                CGSize itemSize = [_delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                maxRowHeight = itemSize.height > maxRowHeight ? itemSize.height : maxRowHeight;
            }
        }
        CGFloat interSectionSpacingY = 0;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
            interSectionSpacingY = [_delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:i];
        }
        
        UIEdgeInsets itemInsets = UIEdgeInsetsZero;
        if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            itemInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i];
        }
        
        maxHeight += maxRowHeight;
        
        if (i != sectionCount-1) {
            maxHeight += interSectionSpacingY + itemInsets.top;
        }
    }
    
    return maxHeight;
}

- (UIEdgeInsets)maxInsets {
    
    UIEdgeInsets maxEdgeInsets;
    NSInteger sectionCount = [self.collectionView numberOfSections];
    if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        UIEdgeInsets topRowInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
        UIEdgeInsets bottomRowInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:sectionCount];
        maxEdgeInsets.top = topRowInsets.top;
        maxEdgeInsets.bottom = bottomRowInsets.bottom;
        maxEdgeInsets.left = bottomRowInsets.left;
        maxEdgeInsets.right = bottomRowInsets.right;
    }
    
    for (int i = 0; i < sectionCount; i++) {
        if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets itemInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:i];
            maxEdgeInsets.left = itemInsets.left;
            maxEdgeInsets.right = itemInsets.right;
        }
    }
    
    return maxEdgeInsets;
}

@end
