//
//  BLTableView+Refresh.h
//  BLTableView
//
//  Created by boundlessocean on 2018/10/25.
//

#import "BLTableView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MTTableViewLoadType){
    MTTableViewLoadTypeReload,
    MTTableViewLoadTypeMore
};

typedef void(^TableViewRefreshBlock)(MTTableViewLoadType loadType);

@interface BLTableView (Refresh)

/** 页码 */
@property (nonatomic ,strong, nullable) NSString *bs_pageIndex;
/** 页码Key */
@property (nonatomic, strong, nullable) NSString *bs_pageIndexKey;

/** 是否支持下拉刷新 */
@property (nonatomic ,assign) BOOL bs_supportRefreshDown;
/** 是否支持上拉加载 */
@property (nonatomic ,assign) BOOL bs_supportRefreshUp;
/** 下拉刷新是否要移除所有数据 默认YES*/
@property (nonatomic ,assign) BOOL bs_refreshDownNeedRemoveAllDatas;

/** 记录刷新的方式 */
@property (nonatomic ,assign, readonly) MTTableViewLoadType loadType;
/** 刷新回调 */
@property (nonatomic, copy, nullable) TableViewRefreshBlock bs_refreshBlock;



/** 结束上拉刷新 */
- (void)bs_tableViewEndRefresh;
/** 进入刷新 */
- (void)bs_tableViewEnterRefresh;

@end

NS_ASSUME_NONNULL_END
