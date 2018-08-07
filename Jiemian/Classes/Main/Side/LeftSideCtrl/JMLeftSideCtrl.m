//
//  JMLeftSideCtrl.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMLeftSideCtrl.h"
#import "JMLeftController.h"

@interface JMLeftSideCtrl()
{
    UIWindow* _window;
}

@property (nonatomic, strong) JMLeftController* leftVC;

@end

@implementation JMLeftSideCtrl

- (instancetype)initWithParentView:(UIView *)parentView
{
    _leftVC = [[JMLeftController alloc] init];
    _leftVC.owner = self;
    
    return [super initWithParentView:parentView rootView:_leftVC.view showWidth:0.72 showDirection:JMSideCtrlShowDirectionFromLeft];
}

- (void)showWithAnimation:(BOOL)isAnimation
{
    _window.alpha = 1.0;
    _window.hidden = NO;
    [super showWithAnimation:isAnimation];
}

- (void)hideWithAnimation:(BOOL)isAnimation
{
    _window.alpha = 0.0;
    _window.hidden = YES;
    [super hideWithAnimation:isAnimation];
}
@end
