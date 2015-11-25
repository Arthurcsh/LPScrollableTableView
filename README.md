# LPScrollableTableView

基于UICollectionView实现的固定header的表格LPScrollableTableView

可以直接通过LPCollectionViewPlainLayout来使用。用法就是UICollectionView的用法，就不作介绍了。但是通过UICollectionView的delegate和datasource直接返回数据的话，跟这种固定header的表格的数据有些差异。所以就封装了LPScrollableTableView对UICollectionView的delegate和datasource进行了包装。通过三个方法分别来获取顶部header数据，左边header数据和内容数据，这样数据更加清晰，使用也更加方便。效果如下：

注：如果图片不能显示请尝试将VPN设为全局模式，也可以通过备用链接查看

Demo[备用链接](http://g.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=fdab84b5fe1986184547ec8c7ad65f4e/4ec2d5628535e5dda9a1a40b70c6a7efcf1b6250.jpg)

![](https://github.com/xiaofei86/LPScrollableTableView/raw/master/Images/1.gif)

全麦运动[备用链接](http://h.picphotos.baidu.com/album/s%3D680%3Bq%3D90/sign=7d23e6eb4dfbfbedd859357748cb860b/a044ad345982b2b7f72e4e1037adcbef77099bb4.jpg)

![](https://github.com/xiaofei86/LPScrollableTableView/raw/master/Images/2.png)

#使用方法

方法命都参照UICollectionView的delegate和datasource，就不介绍了。

	@protocol LPScrollableTableViewDataSource <NSObject>
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemAtIndexPath:(NSIndexPath *)indexPath;
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForSectionHeaderInSection:(NSInteger)section;
	
	- (NSString *)scrollableTableView:(LPScrollableTableView *)scrollableTableView textForItemHeaderInItem:(NSInteger)item;
	
	@end
	
	@protocol LPScrollableTableViewDelegate <NSObject>
	
	- (BOOL)scrollableTableView:(LPScrollableTableView *)scrollableTableView selectEnable:(NSIndexPath *)indexPath;
	
	- (void)scrollableTableView:(LPScrollableTableView *)scrollableTableView didSelectedIndexPaths:(NSArray *)indexPaths;
	
	@end
	
#样式调整
具体使用方法可在Demo中查看。

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




