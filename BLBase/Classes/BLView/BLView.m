//
//  BLView.m
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import "BLView.h"

@implementation BLView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self bs_initializeSubviews];
        [self bs_configActions];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bs_initializeSubviews];
        [self bs_configActions];
    }
    return self;
}

- (void)bs_configActions{};
- (void)bs_initializeSubviews{};

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
