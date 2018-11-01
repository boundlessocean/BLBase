//
//  BLCell.m
//  BLBase
//
//  Created by boundlessocean on 2018/11/1.
//

#import "BLCell.h"

@implementation BLCell
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
@end
