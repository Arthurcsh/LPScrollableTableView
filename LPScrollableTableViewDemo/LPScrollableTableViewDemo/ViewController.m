//
//  ViewController.m
//  LPScrollableTableViewDemo
//
//  Created by XuYafei on 15/10/22.
//  Copyright © 2015年 loopeer. All rights reserved.
//

#import "ViewController.h"
#import "LPScrollableTableView.h"

@interface ViewController () <
    LPScrollableTableViewDelegate,
    LPScrollableTableViewDataSource
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.hidden = YES;
    
    LPScrollableTableView *scrollableTableView = [[LPScrollableTableView alloc] initWithFrame:self.view.bounds];
    scrollableTableView.delegate = self;
    scrollableTableView.dataSource = self;
    scrollableTableView.tableSize = CGSizeMake(10, 20);
    [self.view addSubview:scrollableTableView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)scrollableTableView:(LPScrollableTableView *)scrollableTableView didSelectedIndexPaths:(NSArray *)indexPaths {
    NSLog(@"%@", indexPaths);
}

- (BOOL)scrollableTableView:(LPScrollableTableView *)scrollableTableView selectEnable:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.item];
}

- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemHeaderInItem:(NSInteger)item {
    return [NSString stringWithFormat:@"%ld", (long)item];
}

- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForSectionHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld", (long)section];
}

@end
