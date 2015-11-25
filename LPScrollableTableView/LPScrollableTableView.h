//
//  LPScrollableTableView.h
//  SocialSport
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

/**
 *用法跟collentionView相同,通过dataSource驱动。方法名都是参照collectionView命名的,就不用解释了。
 */

#import <UIKit/UIKit.h>
#import "LPCollectionViewPlainLayout.h"
#import "LPBaseCollectionViewCell.h"

@class LPScrollableTableView;

@protocol LPScrollableTableViewDataSource <NSObject>

- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForSectionHeaderInSection:(NSInteger)section;
- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemHeaderInItem:(NSInteger)item;

@end

@protocol LPScrollableTableViewDelegate <NSObject>

- (BOOL)scrollableTableView:(LPScrollableTableView *)scrollableTableView selectEnable:(NSIndexPath *)indexPath;
- (void)scrollableTableView:(LPScrollableTableView *)scrollableTableView didSelectedIndexPaths:(NSArray *)indexPaths;

@end

@interface LPScrollableTableView : UIView

- (void)reloadData;

@property (nonatomic, assign) CGSize tableSize;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign, readonly) CGFloat interval;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) BOOL titleSeparateVisival;
@property (nonatomic, assign) BOOL contentSeparateVisival;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIColor *contentTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *titleBackgroundColor;
@property (nonatomic, strong) UIColor *contentBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) id<LPScrollableTableViewDataSource> dataSource;
@property (nonatomic, assign) id<LPScrollableTableViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;

@end
