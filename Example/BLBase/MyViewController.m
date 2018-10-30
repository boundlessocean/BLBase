//
//  MyViewController.m
//  BLBase
//
//  Created by fuhaiyang on 10/29/2018.
//  Copyright (c) 2018 fuhaiyang. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)bs_configViewDataSourse{
    [super bs_configViewDataSourse];
    self.loadingView.bs_isNeedLoading = YES;
    
    [self bs_configNavItem:BLNavItemTypeRight
                     image:nil
                     title:@"设置"
                titleColor:[UIColor whiteColor]
                    action:^{
                        NSLog(@"ss");
                    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.loadingView bs_loadFailed:@"加载失败，点击重新加载" IMG:[UIImage imageNamed:@"page_refresh"]];
}
     
- (void)go{
    MyViewController *my = [MyViewController new];
    my.title = @"aaa";
    [self.navigationController pushViewController:my animated:YES];
}

@end
