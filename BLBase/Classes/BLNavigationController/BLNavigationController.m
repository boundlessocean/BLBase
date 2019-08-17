//
//  BLNavigationController.m
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import "BLNavigationController.h"
#import <objc/runtime.h>
@interface BLNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dealWithDargBack];
    [self initinasize];
}

- (void)initinasize{
    // 背景颜色
    [UINavigationBar appearance].barTintColor = _bgColor;
    // 字体大小
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = _titleFont;
    // 字体颜色
    color[NSForegroundColorAttributeName] = _titleColor;
    [[UINavigationBar appearance] setTitleTextAttributes:color];
}

/** 处理侧滑返回 */
- (void)dealWithDargBack{
    
    _canDragBack = YES;
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target
                                                                          action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}


/** 推控制器 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 替换back按钮
        UIImage *back_image = [_backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(0, 0, 44, 44);
        item.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [item setImage:back_image forState:UIControlStateNormal];
        
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
        
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/** 返回 */
- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    // 判断 gestureRecognizer 方向 translatedPoint.x < 0 向右 > 0 向左
    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
    if (_canDragBack && translatedPoint.x > 0 && self.viewControllers.count > 1 ) {
        return YES;
    }else{
        return NO;
    }
}

@end
