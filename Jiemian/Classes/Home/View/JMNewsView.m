//
//  JMNewsView.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNewsView.h"
#import "JMCategoryView.h"
#import "Masonry.h"

@interface JMNewsView() <JMCategoryViewDelegate, UIScrollViewDelegate>
{
    NSInteger _currentIndex;
}

@property (nonatomic, strong) JMCategoryView* categoryView;
@property (nonatomic, strong) NSArray* controllers;
@property (nonatomic, copy) NSMutableArray* titles;
@property (nonatomic, copy) NSMutableArray* views;

@property (nonatomic, strong) UIScrollView* contentView; // 显示控制器view

@end

@implementation JMNewsView

+ (instancetype)newsViewWithSubControllers:(NSArray *)controllers
{
    return [[JMNewsView alloc] initWithSubControllers:controllers];
}

- (instancetype)initWithSubControllers:(NSArray*)controllers
{
    if (self = [super init]) {
        // 1.初始化
        _controllers = controllers;
        _titles = [NSMutableArray array];
        _views = [NSMutableArray array];
        
        // 2.提取标题和View
        [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 提取标题
            UIViewController* vc = obj;
            [_titles addObject:vc.title];
            
            // 提取控制器view
            [_views addObject:vc.view];
        }];
        
        // 3.添加标签等
        [self buildUI];
        
        // 4.加载第一页的数据
        [self callViewWillAppear:0];
    }
    
    return self;
}

- (void)buildUI
{
    // 1.添加分类标签视图
    JMCategoryView* categoryView = [JMCategoryView categoryViewWithItemTitles:_titles];
    categoryView.delegate = self;
    [self addSubview:categoryView];
    
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.width.equalTo(self);
        make.height.equalTo([NSNumber numberWithFloat:[JMCategoryView height]]);
    }];
    self.categoryView = categoryView;
    
    // 2.添加contenView，用于显示控制器视图
    UIScrollView* contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = kGlobalBG;
    contentView.delegate = self;
    contentView.pagingEnabled = YES; // 翻页效果
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryView.mas_bottom).offset(1);
        make.left.right.width.bottom.equalTo(self);
    }];
    self.contentView = contentView;
    
    // 3.添加子控制器到contentView
    int count = _controllers.count;
    UIView* preView = nil;
    for (int i=0; i<count; i++) {
        // 添加视图
        UIView* view = _views[i];
        [self.contentView addSubview:view];
        
        if (preView == nil) { // 判断是第一个，就以contentView的左边为左边
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.width.height.equalTo(self.contentView);
                make.left.equalTo(self.contentView);
            }];
        } else { // 判断不是第一个，就以上一个视图的右边为左边
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.width.height.equalTo(self.contentView);
                make.left.equalTo(preView.mas_right);
            }];
        }
        
        if (i == count-1) { // 判断如果是最后一个控制器，则加上右边约束
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView);
            }];
        }
        
        preView = view;
    }
}

#pragma mark JMCategoryView的代理方法
- (void)categoryView:(JMCategoryView*)categoryView selectedItemFromIndex:(NSInteger)fromIndex to:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    self.contentView.contentOffset = CGPointMake(toIndex * self.contentView.contentSize.width/_controllers.count, 0);
    
    [self callViewWillAppear:toIndex];
    
    _currentIndex = toIndex;
}

// 点击添加按钮的操作
- (void)clickedAddItemButton
{
    if (_clickedAddItemOperation) {
        _clickedAddItemOperation();
    }
}

- (void)layoutSubviews
{
    // 横竖屏切换后，调整滚动到正确位置
    self.contentView.contentOffset = CGPointMake(_currentIndex * self.contentView.contentSize.width/_controllers.count, 0);
}

#pragma mark UIScrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger count = self.views.count;
    NSInteger width = self.contentView.contentSize.width/count;
    
    int page = floor((self.contentView.contentOffset.x - width / 2) / width) + 1;
    
    [self.categoryView setCategoryViewSelectedIndex:page];
    
    [self callViewWillAppear:page];
}

- (void)callViewWillAppear:(NSInteger)index
{
    UIViewController* vc = _controllers[index];
    [vc viewWillAppear:YES];
}


@end
