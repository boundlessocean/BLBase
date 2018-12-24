//
//  BLTableView+Refresh.m
//  BLTableView
//
//  Created by boundlessocean on 2018/10/25.
//

#import "BLTableView+Refresh.h"
#import "MJRefresh.h"
#import <objc/runtime.h>
static char pageIndexKey;
static char pageIndexKeyI;
static char supportRefreshUpKey;
static char supportRefreshDownKey;
static char refreshDownNeedRemoveAllDatasKey;
static char loadTypeKey;
static char refreshBlockKey;
static char dataArrayKey;
@implementation BLTableView (Refresh)

- (NSString *)bs_pageIndex{
    return objc_getAssociatedObject(self, &pageIndexKey);
}

- (NSString *)bs_pageIndexKey{
    return objc_getAssociatedObject(self, &pageIndexKeyI);
}

- (BOOL)bs_supportRefreshUp{
    return objc_getAssociatedObject(self, &supportRefreshUpKey);
}

- (BOOL)bs_supportRefreshDown{
    return objc_getAssociatedObject(self, &supportRefreshDownKey);
}

- (BOOL)bs_refreshDownNeedRemoveAllDatas{
    return objc_getAssociatedObject(self, &refreshDownNeedRemoveAllDatasKey);
}

- (NSString *)bs_dataArrayKey{
    NSString *data = objc_getAssociatedObject(self, &dataArrayKey);
    return data.length ? data : @"Data";
}


- (MTTableViewLoadType)loadType{
    return [objc_getAssociatedObject(self, &loadTypeKey) integerValue];
}

- (TableViewRefreshBlock)bs_refreshBlock{
    return objc_getAssociatedObject(self, &refreshBlockKey);
}

- (void)setBs_pageIndex:(NSString *)bs_pageIndex{
    objc_setAssociatedObject(self, &pageIndexKey, bs_pageIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBs_pageIndexKey:(NSString *)bs_pageIndexKey{
    objc_setAssociatedObject(self, &pageIndexKeyI, bs_pageIndexKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBs_dataArrayKey:(NSString *)bs_dataArrayKey{
    objc_setAssociatedObject(self, &dataArrayKey, bs_dataArrayKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBs_refreshDownNeedRemoveAllDatas:(BOOL)bs_refreshDownNeedRemoveAllDatas{
    objc_setAssociatedObject(self, &refreshDownNeedRemoveAllDatasKey, @(bs_refreshDownNeedRemoveAllDatas), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLoadType:(MTTableViewLoadType)loadType{
    objc_setAssociatedObject(self, &loadTypeKey, @(loadType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)setBs_refreshBlock:(TableViewRefreshBlock)bs_refreshBlock{
    objc_setAssociatedObject(self, &refreshBlockKey, bs_refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}





- (void)setBs_supportRefreshUp:(BOOL)bs_supportRefreshUp{
    
    if (self.bs_supportRefreshUp != bs_supportRefreshUp) {
        objc_setAssociatedObject(self, &supportRefreshUpKey, @(bs_supportRefreshUp), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (bs_supportRefreshUp) {
            self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
                self.loadType = MTTableViewLoadTypeMore;
                !self.bs_refreshBlock ? : self.bs_refreshBlock(MTTableViewLoadTypeMore);
            }];
        }else {
            [self.mj_footer removeFromSuperview];
        }
    }
}

- (void)setBs_supportRefreshDown:(BOOL)bs_supportRefreshDown{
    if (self.bs_supportRefreshDown != bs_supportRefreshDown) {
        objc_setAssociatedObject(self, &supportRefreshDownKey, @(bs_supportRefreshDown), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (bs_supportRefreshDown) {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                self.loadType = MTTableViewLoadTypeReload;
                if (self.bs_supportRefreshUp) {
                    [self.mj_footer resetNoMoreData];
                }
                if (self.bs_refreshDownNeedRemoveAllDatas) {
                    [self.bs_dataArray removeAllObjects];
                }
                self.bs_pageIndex = nil;
                !self.bs_refreshBlock ? : self.bs_refreshBlock(MTTableViewLoadTypeReload);
            }];

            ((MJRefreshNormalHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = YES;
            ((MJRefreshNormalHeader *)self.mj_header).stateLabel.hidden = YES;
        } else {
            [self.mj_header removeFromSuperview];
        }
    }
}


#pragma mark - - Public

- (void)bs_tableViewEndRefresh{
    if (self.bs_supportRefreshDown) {
        [self.mj_header endRefreshing];
    }
    
    if(self.bs_supportRefreshUp){
        [self.mj_footer endRefreshing];
    }
}

- (void)bs_tableViewEnterRefresh{
    if (self.bs_supportRefreshDown) {
        [self.mj_header beginRefreshing];
    }
}


- (void)bs_tableViewEndRefreshWithNoMoreData{
    if(self.bs_supportRefreshUp){
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)bs_configRefreshTable{
    self.bs_supportRefreshUp = YES;
    self.bs_supportRefreshDown = YES;
    self.bs_refreshDownNeedRemoveAllDatas = YES;
    self.loadType = -1;
}
@end
