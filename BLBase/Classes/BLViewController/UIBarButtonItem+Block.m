//
//  UIBarButtonItem+Block.m
//  BLBase
//
//  Created by boundlessocean on 2019/3/4.
//

#import "UIBarButtonItem+Block.h"
#import <objc/runtime.h>
static const int BLItemTitleBlock_key;
static const int BLItemImageBlock_key;
@implementation UIBarButtonItem (Block)
+ (instancetype)initWithTitle:(NSString *)title
                        style:(UIBarButtonItemStyle)style
                  blockAction:(void(^)(void))itemAction{
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:title style:style target:self action:@selector(titleActionDo:)];
    objc_setAssociatedObject(bar, &BLItemTitleBlock_key, itemAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return bar;
}

+ (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                  blockAction:(void(^)(void))itemAction{
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:image style:style target:self action:@selector(imgActionDo:)];
    objc_setAssociatedObject(bar, &BLItemImageBlock_key, itemAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return bar;
    
}

+ (void)titleActionDo:(UIBarButtonItem *)sender {
    void(^itemAction)(void)  = objc_getAssociatedObject(sender, &BLItemTitleBlock_key);
    !itemAction ? : itemAction();
}

+ (void)imgActionDo:(UIBarButtonItem *)sender {
    void(^itemAction)(void)  = objc_getAssociatedObject(sender, &BLItemImageBlock_key);
    !itemAction ? : itemAction();
}
@end
