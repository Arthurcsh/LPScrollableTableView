# LPScrollableTableView

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/xiaofei86/LPScrollableTableView/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYKit.svg?style=flat)](http://www.apple.com/ios/)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://en.wikipedia.org/wiki/IOS_7)&nbsp;
[![Support](https://img.shields.io/badge/blog-xuyafei.cn-orange.svg)](http://www.xuyafei.cn)&nbsp;

基于UICollectionView实现的固定header的表格LPScrollableTableView。

[图片备用链接](http://g.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=fdab84b5fe1986184547ec8c7ad65f4e/4ec2d5628535e5dda9a1a40b70c6a7efcf1b6250.jpg)

<img src = "https://github.com/xiaofei86/LPScrollableTableView/raw/master/Images/1.gif" width = 373>

[图片备用链接](http://h.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=7d23e6eb4dfbfbedd859357748cb860b/a044ad345982b2b7f72e4e1037adcbef77099bb4.jpg)

<img src = "https://github.com/xiaofei86/LPScrollableTableView/raw/master/Images/2.png" width = 373>

#Usage

可直接在自己的UICollectionView使用LPCollectionViewPlainLayout。但是通过UICollectionView的delegate和datasource注入数据于这种固定header的表格的数据需求有些差异。而LPScrollableTableView对UICollectionView的delegate和datasource进行了包装。通过三个方法分别来获取顶部header数据，左边header数据和内容数据。

####DataSource

方法命名都参照UICollectionView的delegate和datasource。

	@protocol LPScrollableTableViewDataSource <NSObject>
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemAtIndexPath:(NSIndexPath *)indexPath;
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForSectionHeaderInSection:(NSInteger)section;
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemHeaderInItem:(NSInteger)item;
	
	@end
	
	@protocol LPScrollableTableViewDelegate <NSObject>
	
	- (BOOL)scrollableTableView:(LPScrollableTableView *)scrollableTableView selectEnable:(NSIndexPath *)indexPath;
	
	- (void)scrollableTableView:(LPScrollableTableView *)scrollableTableView didSelectedIndexPaths:(NSArray *)indexPaths;
	
	@end
	
####Configuration

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