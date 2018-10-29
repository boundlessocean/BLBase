//
//  BLTableView+EmptyDataSource.m
//  BLTableView
//
//  Created by boundlessocean on 2018/10/25.
//

#import "BLTableView+EmptyDataSource.h"
#import "UIScrollView+EmptyDataSet.h"
#import <objc/runtime.h>
static char emptyImageKey;
static char emptyTitleKey;
static char emptyBgColorKey;
@interface BLTableView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation BLTableView (EmptyDataSource)

#pragma mark - - OverWrite
- (void)bs_configTable{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

#pragma mark - - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = self.bs_emptyTitle ? self.bs_emptyTitle : @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:102/255
                                                                                 green:102/255
                                                                                  blue:102/255
                                                                                 alpha:1]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return  self.bs_emptyImage;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UITableView *)scrollView{
    return -45 + scrollView.tableHeaderView.bounds.size.height;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.bs_emptyBgColor ? self.bs_emptyBgColor : [UIColor whiteColor];
}


#pragma mark - - Property
- (void)setBs_emptyImage:(NSString *)bs_emptyImage{
    objc_setAssociatedObject(self,
                             &emptyImageKey,
                             bs_emptyImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBs_emptyTitle:(NSString *)bs_emptyTitle{
    objc_setAssociatedObject(self,
                             &emptyTitleKey,
                             bs_emptyTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBs_emptyBgColor:(UIColor *)bs_emptyBgColor{
    objc_setAssociatedObject(self,
                             &emptyBgColorKey,
                             bs_emptyBgColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)bs_emptyImage{
    return objc_getAssociatedObject(self, &emptyImageKey);
}

- (NSString *)bs_emptyTitle{
    return objc_getAssociatedObject(self, &emptyTitleKey);
}

- (UIColor *)bs_emptyBgColor{
    return objc_getAssociatedObject(self, &emptyBgColorKey);
}

@end
