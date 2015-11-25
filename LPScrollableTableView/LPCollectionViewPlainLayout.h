//
//  LPCollectionViewPlainLayout.h
//  LPScrollableTableView
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPBidirectionalCollectionLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (BOOL)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout*)collectionViewLayout shouldFloatSectionAtIndex:(NSInteger)section;

- (BOOL)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout*)collectionViewLayout shouldFloatItemAtIndex:(NSInteger)item;

@end

@interface LPCollectionViewPlainLayout : UICollectionViewFlowLayout

@end
