//
//  CommTool.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/13.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "CommTool.h"

@implementation CommTool

+ (UIViewController*)getViewControllerOfView:(UIView*)view
{
    id target = view;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            return target;
        }
    }
    return nil;
}

@end
