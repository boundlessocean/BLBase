//
//  UIBarButtonItem+Block.h
//  BLBase
//
//  Created by boundlessocean on 2019/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Block)
+ (instancetype)initWithTitle:(NSString *)title
                        style:(UIBarButtonItemStyle)style
                  blockAction:(void(^)(void))itemAction;

+ (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                  blockAction:(void(^)(void))itemAction;
@end

NS_ASSUME_NONNULL_END
