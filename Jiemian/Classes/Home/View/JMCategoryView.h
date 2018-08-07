//
//  JMCategoryView.h
//  TestDemo
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMCategoryView;

@protocol JMCategoryViewDelegate <NSObject>

- (void)categoryView:(JMCategoryView*)categoryView selectedItemFromIndex:(NSInteger)fromIndex to:(NSInteger)toIndex;
- (void)clickedAddItemButton;

@end

@interface JMCategoryView : UIView

@property (nonatomic, weak) id<JMCategoryViewDelegate> delegate;

- (instancetype)initWithItemTitles:(NSArray*)itemTiltes;
+ (instancetype)categoryViewWithItemTitles:(NSArray*)itemTiltes;

+ (CGFloat)height;

- (void)setCategoryViewSelectedIndex:(NSInteger)index;

@end
