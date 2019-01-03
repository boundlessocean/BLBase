//
//  BLTableView+EmptyDataSource.h
//  BLTableView
//
//  Created by boundlessocean on 2018/10/25.
//

#import "BLTableView.h"
#import "UIScrollView+EmptyDataSet.h"
NS_ASSUME_NONNULL_BEGIN

@interface BLTableView (EmptyDataSource)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 无数据标题 */
@property (nonatomic, strong) NSString *bs_emptyTitle;
/** 无数据图 */
@property (nonatomic, strong) UIImage *bs_emptyImage;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *bs_emptyBgColor;
@end

NS_ASSUME_NONNULL_END
