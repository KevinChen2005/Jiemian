//
//  JMSideCtrl.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMSideCtrl.h"

#define kCoverAlpha 0.7 //侧边栏显示时遮盖的透明度
#define kCoverAlphaInit 0.0 //侧边栏初始时时遮盖的透明度
#define kAnimationTime 0.5

@interface JMSideCtrl()
{
    UIView* _parentView;
    UIView* _rootView;
    CGFloat _widthScale; // rootView占父视图的宽度比 0 ~ 1.0
    
    NSInteger _positionLeftInit; // 初始时候左边缘的位置
    NSInteger _positionLeftShow; // 显示时候左边缘的位置
    
    CGFloat _positionInitflag;
    CGFloat _positionShowScale;
}

@property (nonatomic, strong) UIView* cover;

@end

@implementation JMSideCtrl

- (instancetype)initWithParentView:(UIView *)parentView rootView:(UIView *)rootView showWidth:(CGFloat)widthScale showDirection:(JMSideCtrlShowDirection)direction
{
    if (self = [super init]) {
        _parentView = parentView;
        _rootView = rootView;
        
        if (widthScale<0.0 || widthScale > 1.0) {
            _widthScale = 0.7;
        } else {
            _widthScale = widthScale;
        }
        
        if (direction == JMSideCtrlShowDirectionFromLeft) {
            _positionInitflag = -1;
            _positionShowScale = 0.0;
        } else if (direction == JMSideCtrlShowDirectionFromRight) {
            _positionInitflag = 1;
            _positionShowScale = 1.0 - _widthScale;
        }
 
        // 1.cover
        [_parentView addSubview:self.cover];
        [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(_parentView);
        }];
        self.cover.alpha = kCoverAlphaInit;
        
        // 2.root视图
        [_parentView addSubview:_rootView];
        [_rootView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_parentView);
            make.width.equalTo(self.cover.mas_width).multipliedBy(_widthScale);
            make.left.equalTo(self.cover.mas_right).multipliedBy(_positionInitflag);
        }];
        
        if ([parentView isKindOfClass:[UIWindow class]]) {
            UIWindow* window = (UIWindow*)parentView;
            _parentVC = window.rootViewController;
        } else {
            _parentVC = [CommTool getViewControllerOfView:parentView];
        }
    }
    
    return self;
}

- (UIView *)cover
{
    if (_cover == nil) {
        UIButton* cover = [UIButton buttonWithType:UIButtonTypeCustom];
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self action:@selector(clickCover) forControlEvents:UIControlEventAllTouchEvents];
        _cover = cover;
    }
    
    return _cover;
}

- (void)showLeftView:(BOOL)isShow withAnimation:(BOOL)isAnimation
{
    CGFloat alpha = kCoverAlphaInit;
    
    if (isShow) {
        [_rootView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_parentView);
            make.width.equalTo(self.cover.mas_width).multipliedBy(_widthScale);
            if (_positionShowScale == 0.0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.cover.mas_right).multipliedBy(_positionShowScale);
            }            
        }];
        alpha = kCoverAlpha;
        
    } else {
        [_rootView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_parentView);
            make.width.equalTo(self.cover.mas_width).multipliedBy(_widthScale);
            make.left.equalTo(self.cover.mas_right).multipliedBy(_positionInitflag);
        }];
        alpha = kCoverAlphaInit;
    }
    
    if (isAnimation) {
        [UIView animateWithDuration:kAnimationTime animations:^{
            [_parentView layoutIfNeeded];
            self.cover.alpha = alpha;
        }];
    } else {
        [_parentView layoutIfNeeded];
        self.cover.alpha = alpha;
    }
}

- (void)clickCover
{
    [self hideWithAnimation:YES];
}

- (void)showWithAnimation:(BOOL)isAnimation
{
    [self showLeftView:YES withAnimation:isAnimation];
}

- (void)hideWithAnimation:(BOOL)isAnimation
{
    [self showLeftView:NO withAnimation:isAnimation];
}

@end
