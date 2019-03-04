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
    objc_setAssociatedObject(self, &BLItemTitleBlock_key, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[UIBarButtonItem alloc] initWithTitle:title style:style target:self action:@selector(titleActionDo:)];
}

+ (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                  blockAction:(void(^)(void))itemAction{
    objc_setAssociatedObject(self, &BLItemImageBlock_key, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[UIBarButtonItem alloc] initWithImage:image style:style target:self action:@selector(imgActionDo:)];
    
}

- (void)titleActionDo:(id)sender {
    void(^itemAction)(void)  = objc_getAssociatedObject(self, &BLItemTitleBlock_key);
    !itemAction ? : itemAction();
}

- (void)imgActionDo:(id)sender {
    void(^itemAction)(void)  = objc_getAssociatedObject(self, &BLItemImageBlock_key);
    !itemAction ? : itemAction();
}
@end
