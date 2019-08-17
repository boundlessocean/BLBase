//
//  BLView.h
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLView : UIView
@property(nonatomic,copy) void(^bs_viewAction)(id data,...);
- (void)bs_initializeSubviews;
- (void)bs_configActions;
@end

NS_ASSUME_NONNULL_END
