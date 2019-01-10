//
//  BLViewController.h
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import <UIKit/UIKit.h>
@class BLLoadingView;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, BLNavItemType){
    BLNavItemTypeRight,
    BLNavItemTypeLeft,
};
@interface BLViewController : UIViewController

/** loading视图 */
@property (nonatomic, strong) BLLoadingView *bs_loadingView;
/** 事件响应 */
@property(nonatomic, copy) void(^bs_viewAction)(id data,...);
/** 是否需要切换状态栏 */
@property (nonatomic, assign) BOOL bs_needSwitchStatuBarStyle;

- (void)bs_initializeSubviews;
- (void)bs_configActions;
- (void)bs_configViewDataSourse;
- (void)bs_requestData;

/**
 设置导航栏左右Item

 @param type 左右
 @param image 图片
 @param title 文字
 @param titleColor 文字颜色
 @param itemAction 事件回调
 */
- (void)bs_configNavItem:(BLNavItemType)type
                   image:(UIImage * _Nullable )image
                   title:(NSString * _Nullable )title
              titleColor:(UIColor * _Nullable )titleColor
                  action:(void(^ _Nullable )(void))itemAction;

@end

NS_ASSUME_NONNULL_END

typedef NS_ENUM(NSInteger,BLLoadingViewState){
    BLLoadingViewStateNormol,
    BLLoadingViewStateLoding,
    BLLoadingViewStateFailed,
};

@interface BLLoadingView : UIView
/** 是否需要loading视图 */
@property (nonatomic, assign) BOOL bs_isNeedLoading;
/** 加载失败，点击刷新页面 */
@property (nonatomic, copy) void(^bs_reloadData)(void);
/** 加载状态 */
@property (nonatomic, assign, readonly) BLLoadingViewState bs_lodingState;
/** loading */
- (void)bs_showLoading;
- (void)bs_dismissLoading;
- (void)bs_loadFailed:(NSString *)message
                  IMG:(UIImage *)failedIMG;
@end
