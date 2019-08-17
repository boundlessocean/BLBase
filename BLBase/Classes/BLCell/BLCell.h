//
//  BLCell.h
//  BLBase
//
//  Created by boundlessocean on 2018/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLCell : UITableViewCell

@property(nonatomic,copy) void(^bs_viewAction)(id data,...);
- (void)bs_initializeSubviews;
- (void)bs_configActions;
@end

NS_ASSUME_NONNULL_END
