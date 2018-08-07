//
//  JMUserCtrl.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMUserCtrl.h"
#import "JMUserController.h"

@interface JMUserCtrl()

@property (nonatomic, strong) JMUserController* userVC;
@property (nonatomic, strong) UIButton* topCover; //

@end

@implementation JMUserCtrl

- (instancetype)initWithParentView:(UIView *)parentView
{
    _userVC = [[JMUserController alloc] init];
    
    UIViewController* vc = [CommTool getViewControllerOfView:parentView];
    UIView* navBar = vc.navigationController.navigationBar;
    [navBar addSubview:self.topCover];
    [self.topCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(navBar);
    }];
    self.topCover.alpha = 0.0;
    
    return (self = [super initWithParentView:parentView rootView:_userVC.view showWidth:0.65 showDirection:JMSideCtrlShowDirectionFromRight]);
}

- (UIButton *)topCover
{
    if (_topCover == nil) {
        _topCover = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topCover addTarget:self action:@selector(clickTopCover) forControlEvents:UIControlEventAllTouchEvents];
    }
    
    return _topCover;
}

- (void)clickTopCover
{
    [self hideWithAnimation:YES];
}

// 重写父类的方法
- (void)clickCover
{
    [self hideWithAnimation:YES];
}

- (void)showWithAnimation:(BOOL)isAnimation
{
    [super showWithAnimation:isAnimation];
    
    self.topCover.alpha = 0.5;
}

- (void)hideWithAnimation:(BOOL)isAnimation
{
    [super hideWithAnimation:isAnimation];
    
    self.topCover.alpha = 0.0;
}

@end
