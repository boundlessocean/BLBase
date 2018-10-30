//
//  BLTabBarController.h
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLTabBarController : UITabBarController
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectColor;

- (void)initializeNav:(UINavigationController *)nav
                   VC:(UIViewController *)vc
                title:(NSString *)title
                image:(UIImage *)image
        selectedImage:(UIImage *)selectedImage;
@end

NS_ASSUME_NONNULL_END
