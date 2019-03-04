//
//  BLTabBarController.m
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import "BLTabBarController.h"
@interface BLTabBarController ()

@end

@implementation BLTabBarController

#pragma mark - - 添加控制器
- (void)initializeNav:(UINavigationController *)nav
                   VC:(UIViewController *)vc
                title:(NSString *)title
                image:(UIImage *)image
        selectedImage:(UIImage *)selectedImage {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = _defaultColor;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:11];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = _selectColor;
    selectTextAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:11];
    
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    if (nav) {
        [nav addChildViewController:vc];
        [self addChildViewController:nav];
    } else {
        [self addChildViewController:vc];
    }
}

@end
