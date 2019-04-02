//
//  BLTableView+EmptyDataSource.h
//  BLTableView
//
//  Created by boundlessocean on 2018/10/25.
//

#import "BLTableView.h"
#import "UIScrollView+EmptyDataSet.h"

/** 已经显示footer */
typedef void(^TableViewEmptyDataTapBlock)(UIScrollView *scrollView, UIView *view);
NS_ASSUME_NONNULL_BEGIN

@interface BLTableView (EmptyDataSource)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 无数据标题 */
@property (nonatomic, strong) NSString *bs_emptyTitle;
/** 无数据图 */
@property (nonatomic, strong) UIImage *bs_emptyImage;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *bs_emptyBgColor;

@property (nonatomic, copy ,nullable) TableViewEmptyDataTapBlock bs_emptyDataTapBlock;

@end

NS_ASSUME_NONNULL_END
