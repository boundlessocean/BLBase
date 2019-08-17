//
//  BLTableView.h
//  BLTableView
//
//  Created by boundlessocean on 2018/10/24.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MTTableViewRegisteType){
    MTTableViewRegisteTypeNib,
    MTTableViewRegisteTypeClass
};

#define kDefaultTableFrame CGRectMake(\
0,\
0,\
UIScreen.mainScreen.bounds.size.width,\
UIScreen.mainScreen.bounds.size.height - UIApplication.sharedApplication.statusBarFrame.size.height)

/** cell */
typedef UITableViewCell *(^TableViewCellBlock)(UITableViewCell * cell,NSIndexPath * indexPath);
/** 行高 */
typedef CGFloat (^TableViewHeightForRowBlock)(NSIndexPath *indexPath);
/** 选中 */
typedef void(^TableViewCellSelectedBlock)(NSIndexPath * indexPath);
/** 分区数 */
typedef NSInteger(^TableViewNumberOfSectionBlock)(void);
/** 行数 */
typedef NSInteger(^TableViewNumberOfRowsBlock)(NSInteger section);
/** 尾 */
typedef UIView *(^TableViewFooterBlock)(NSInteger section);
/** 尾高 */
typedef CGFloat(^TableViewHeightForFooterBlock)(NSInteger section);
/** 头 */
typedef UIView *(^TableViewHeaderBlock)(NSInteger section);
/** 头高 */
typedef CGFloat(^TableViewHeightForHeaderBlock)(NSInteger section);
/** 索引 */
typedef NSArray <NSString *> *(^TableViewSectionIndexTitlesBlock)(void);
/** 索引点击 */
typedef NSInteger (^TableViewSectionIndexSelectedBlock)(NSString *title,NSInteger index);
/** Scroll滚动 */
typedef void(^TableViewDidScroll)(__kindof UIScrollView *scrollView);

/** 即将显示cell */
typedef void(^TableViewCellWillDisplayBlock)(NSIndexPath * indexPath, UITableViewCell *cell);
/** 即将显示Header */
typedef void(^TableViewHeaderWillDisplayBlock)(NSInteger section, UIView *header);
/** 即将显示footer */
typedef void(^TableViewFooterWillDisplayBlock)(NSInteger section, UIView *header);

/** 已经显示cell */
typedef void(^TableViewCellDidDisplayBlock)(NSIndexPath * indexPath, UITableViewCell *cell);
/** 已经显示Header */
typedef void(^TableViewHeaderDidDisplayBlock)(NSInteger section, UIView *header);
/** 已经显示footer */
typedef void(^TableViewFooterDidDisplayBlock)(NSInteger section, UIView *header);

@interface BLTableView : UITableView


/** UITableViewDataSource,UITableViewDelegate */
@property (nonatomic, copy ,nullable) TableViewNumberOfSectionBlock bs_sectionCountBlock;
@property (nonatomic, copy ,nullable) TableViewNumberOfRowsBlock bs_rowCountBlock;
@property (nonatomic, copy ,nullable) TableViewCellBlock bs_cellBlock;
@property (nonatomic, copy ,nullable) TableViewFooterBlock bs_footerBlock;
@property (nonatomic, copy ,nullable) TableViewHeaderBlock bs_headerBlock;
@property (nonatomic, copy ,nullable) TableViewHeightForRowBlock bs_rowHeightBlock;
@property (nonatomic, copy ,nullable) TableViewHeightForHeaderBlock bs_headerHeightBlock;
@property (nonatomic, copy ,nullable) TableViewHeightForFooterBlock bs_footerHeightBlock;
@property (nonatomic, copy ,nullable) TableViewCellSelectedBlock bs_cellSelectedBlock;
@property (nonatomic, copy ,nullable) TableViewSectionIndexTitlesBlock bs_sectionIndexTitlesBlock;
@property (nonatomic, copy ,nullable) TableViewSectionIndexSelectedBlock bs_sectionIndexSelectedBlock;

@property (nonatomic, copy ,nullable) TableViewCellDidDisplayBlock bs_cellDidDisplayBlock;
@property (nonatomic, copy ,nullable) TableViewCellWillDisplayBlock bs_cellWillDisplayBlock;
@property (nonatomic, copy ,nullable) TableViewHeaderDidDisplayBlock bs_headerDidDisplayBlock;
@property (nonatomic, copy ,nullable) TableViewHeaderWillDisplayBlock bs_headerWillDisplayBlock;
@property (nonatomic, copy ,nullable) TableViewFooterDidDisplayBlock bs_footerDidDisplayBlock;
@property (nonatomic, copy ,nullable) TableViewFooterWillDisplayBlock bs_footerWillDisplayBlock;

/** UIScrollViewDelegate */
@property (nonatomic, copy ,nullable) TableViewDidScroll bs_viewDidScroll;

/** 默认注册类型为NIB,请在设置重用标示前修改 */
@property (nonatomic ,assign) MTTableViewRegisteType bs_registeType;
/** 重用标示 */
@property (nonatomic ,strong ,nullable) NSMutableArray *bs_identifiers;
@property (nonatomic ,strong ,nullable) NSString *bs_identifier;
/** 数据model类名 */
@property (nonatomic, strong ,nullable) NSString *bs_modelClass;
/** 数据源 */
@property (nonatomic, strong ,nullable) NSMutableArray *bs_dataArray;
/** 是否首次加载 */
@property (nonatomic ,assign ,readonly) BOOL bs_isFristLoad;


/** 不使用默认frame，请调用默认初始化方法（initWithFrame: style: ）*/
+ (instancetype)bs_tableView;
+ (instancetype)bs_tableViewWithStyle:(UITableViewStyle)style;
/** 滚动到底部 */
- (void)bs_tableViewScrollToBottom;

@end
NS_ASSUME_NONNULL_END
