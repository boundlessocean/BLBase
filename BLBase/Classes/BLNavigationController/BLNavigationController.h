//
//  BLNavigationController.h
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLNavigationController : UINavigationController
/** 背景颜色 */
@property (nonatomic, strong) UIColor *bgColor;
/** 标题字体大小 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题字体颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 返回图标 */
@property (nonatomic, strong) UIImage *backImage;
/** 是否可以侧滑返回 */
@property (nonatomic, assign) BOOL canDragBack;
@end

NS_ASSUME_NONNULL_END
