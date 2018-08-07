//
//  JMSideCtrl.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JMSideCtrlShowDirection) {
    JMSideCtrlShowDirectionFromLeft = 0,
    JMSideCtrlShowDirectionFromRight
};

@interface JMSideCtrl : NSObject

@property (nonatomic, strong, readonly) UIViewController* parentVC;

/**
 *  @param parentView 侧边栏将要显示在其中的父视图
 *  @param rootView 将要显示在侧边栏中的view，即根视图
 *  @param widthScale rootView占父视图的宽度比 0 ~ 1.0
 *  @param direction 侧边视图显示的方向
 */
- (instancetype)initWithParentView:(UIView*)parentView rootView:(UIView*)rootView showWidth:(CGFloat)widthScale showDirection:(JMSideCtrlShowDirection)direction;

/**
 *  显示侧边栏
 *  @param isAnimation 是否显示动画
 */
- (void)showWithAnimation:(BOOL)isAnimation;

/**
 *  隐藏侧边栏
 *  @param isAnimation 是否显示动画
 */
- (void)hideWithAnimation:(BOOL)isAnimation;


@end
