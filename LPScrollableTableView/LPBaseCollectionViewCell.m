//
//  LPBaseCollectionViewCell.m
//  LPScrollableTableView
//
//  Created by XuYafei on 15/10/15.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "LPBaseCollectionViewCell.h"

@implementation LPBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

+ (NSString *)cellIdentifier {
    return @"kBaseCollectionViewCell";
}

@end
