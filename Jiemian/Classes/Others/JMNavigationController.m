//
//  JMNavigationController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNavigationController.h"

@interface JMNavigationController ()

@end

@implementation JMNavigationController

+ (void)initialize
{
    UINavigationBar* bar = [UINavigationBar appearance];
    
//    bar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_background.png"]];
    
    bar.barTintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsCompact];
}

@end
