//
//  ICStyledNavigationBar.m
//  iOSChallenge
//
//  Created by Nicholas Kraft on 5/29/15.
//  Copyright (c) 2015 Nicholas Kraft. All rights reserved.
//

#import "ICStyledNavigationBar.h"

@implementation ICStyledNavigationBar

+ (void)initialize {
    [[ICStyledNavigationBar appearance] setBackgroundImage:[UIImage new]
                                             forBarMetrics:UIBarMetricsDefault];
    [ICStyledNavigationBar appearance].shadowImage = [UIImage new];
    [ICStyledNavigationBar appearance].translucent = YES;
    
    [ICStyledNavigationBar appearance].tintColor =[UIColor blackColor];
}

@end
