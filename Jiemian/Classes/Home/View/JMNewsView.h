//
//  JMNewsView.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickedAddItemBlock)();

@interface JMNewsView : UIView

- (instancetype)initWithSubControllers:(NSArray*)controllers;
+ (instancetype)newsViewWithSubControllers:(NSArray*)controllers;

@property (nonatomic, copy) clickedAddItemBlock clickedAddItemOperation;

@end
