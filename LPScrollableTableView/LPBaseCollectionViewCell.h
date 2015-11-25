//
//  LPBaseCollectionViewCell.h
//  LPScrollableTableView
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

+ (NSString *)cellIdentifier;

@end
