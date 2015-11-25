//
//  LPScrollableTableView.m
//  SocialSport
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 Loopeer. All rights reserved.
//

#import "LPScrollableTableView.h"

@interface LPScrollableTableView () <
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@end

@implementation LPScrollableTableView {
    LPCollectionViewPlainLayout *_collectionViewPlainLayout;
    UICollectionView *_collectionView;
}

#pragma mark - UIView Initlization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self resetData];
        _collectionViewPlainLayout = [[LPCollectionViewPlainLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_collectionViewPlainLayout];
        [_collectionView registerClass:[LPBaseCollectionViewCell class] forCellWithReuseIdentifier:[LPBaseCollectionViewCell cellIdentifier]];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
    }
    return self;
}

- (void)resetData {
    _tableSize = CGSizeMake(0, 0);
    _itemSize = CGSizeMake(65, 40);
    _titleSize = _itemSize;
    _interval = 0;
    _borderWidth = 0.5;
    _titleSeparateVisival = NO;
    _contentSeparateVisival = YES;
    _textAlignment = NSTextAlignmentCenter;
    
    _titleFont = [UIFont systemFontOfSize:14];
    _contentFont = [UIFont systemFontOfSize:14];
    _titleTextColor =[UIColor darkGrayColor];
    _contentTextColor = [UIColor grayColor];
    _selectedTextColor = [UIColor whiteColor];
    _titleBackgroundColor = [UIColor lightGrayColor];
    _contentBackgroundColor = [UIColor whiteColor];
    _selectedBackgroundColor = [UIColor orangeColor];
    _borderColor = [UIColor grayColor];
    self.backgroundColor = _titleBackgroundColor;
    
    _selectedIndexPaths = [NSMutableArray array];
}

- (void)reloadData {
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout shouldFloatSectionAtIndex:(NSInteger)section {
    return section == 0;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout shouldFloatItemAtIndex:(NSInteger)item {
    return item == 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollableTableView:selectEnable:)]) {
        if (![self.delegate scrollableTableView:self
                                   selectEnable:[NSIndexPath indexPathForItem:indexPath.item - 1
                                                                    inSection:indexPath.section - 1]]) {
            return;
        }
    }
    if (indexPath.section) {
        [self selectedIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(_itemSize.width, _titleSize.height);
    } else {
        return _itemSize;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _interval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(_interval, _interval, _interval, _interval);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _tableSize.height + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tableSize.width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPBaseCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    cell.layer.borderColor = _borderColor.CGColor;
    cell.textLabel.textAlignment = _textAlignment;
    cell.textLabel.alpha = 1.0;
    if (indexPath.section == 0 || indexPath.item == 0) {
        cell.textLabel.font = _titleFont;
        cell.backgroundColor = _titleBackgroundColor;
        cell.textLabel.textColor = _titleTextColor;
        if (_titleSeparateVisival) {
            cell.layer.borderWidth = _borderWidth / 2;
        } else {
            cell.layer.borderWidth = 0;
        }
        
        if (indexPath.section == 0 && indexPath.item == 0) {
            cell.textLabel.text = @"";
        } else if (indexPath.section == 0 && self.dataSource &&
            [self.dataSource respondsToSelector:@selector(scrollableTableView:textForItemHeaderInItem:)]) {
            cell.textLabel.text = [self.dataSource scrollableTableView:self textForItemHeaderInItem:indexPath.item - 1];
        } else if (indexPath.item == 0 && self.dataSource &&
            [self.dataSource respondsToSelector:@selector(scrollableTableView:textForSectionHeaderInSection:)]) {
            cell.textLabel.text = [self.dataSource scrollableTableView:self textForSectionHeaderInSection:indexPath.section - 1];
        } else {
            cell.textLabel.text = @"-";
        }
    } else {
        cell.textLabel.font = _titleFont;
        if ([self isSelectedIndexPath:indexPath]) {
            cell.backgroundColor = _selectedBackgroundColor;
            cell.textLabel.textColor = _selectedTextColor;
        } else {
            cell.backgroundColor = _contentBackgroundColor;
            cell.textLabel.textColor = _contentTextColor;
        }
        
        if (_contentSeparateVisival) {
            cell.layer.borderWidth = _borderWidth / 2;
        } else {
            cell.layer.borderWidth = 0;
        }
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(scrollableTableView:textForItemAtIndexPath:)]) {
            cell.textLabel.text = [self.dataSource scrollableTableView:self textForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section - 1]];
        } else {
            cell.textLabel.text = @"-";
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollableTableView:selectEnable:)]) {
            if (![self.delegate scrollableTableView:self selectEnable:[NSIndexPath indexPathForItem:indexPath.item - 1
                                                                                          inSection:indexPath.section - 1]]) {
                cell.textLabel.alpha = 0.6;
            }
        }
    }
    return cell;
}

#pragma mark - Private Method

- (BOOL)isSelectedIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < _selectedIndexPaths.count; i++) {
        if ([_selectedIndexPaths[i] section] == indexPath.section - 1 &&
            [(NSIndexPath *)_selectedIndexPaths[i] item] == indexPath.item - 1 ) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)selectedIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < _selectedIndexPaths.count; i++) {
        if ([_selectedIndexPaths[i] section] == indexPath.section - 1 &&
            [(NSIndexPath *)_selectedIndexPaths[i] item] == indexPath.item - 1) {
            [_selectedIndexPaths removeObjectAtIndex:i];
            [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [self invokeDelegate];
            return YES;
        }
    }
    [_selectedIndexPaths addObject:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section - 1]];
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self invokeDelegate];
    return NO;
}

- (void)invokeDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollableTableView:didSelectedIndexPaths:)]) {
        [self.delegate scrollableTableView:self didSelectedIndexPaths:_selectedIndexPaths];
    }
}

@end
