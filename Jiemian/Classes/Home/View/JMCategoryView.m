//
//  JMCategoryView.m
//  TestDemo
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMCategoryView.h"
#import "JMCategoryItem.h"

#define kItemW ([JMCategoryItem size].width)
#define kItemH ([JMCategoryItem size].height)

#define kBackgroundColor kColor(230, 230, 230)
#define kScrollViewBg kColor(248, 248, 248)
#define kAddBtnTitleColor kColor(249, 0, 0)
#define kAddBtnBgColor kColor(248, 248, 248)

#define kMargin 1
#define kScrollLeftInset 15

@interface JMCategoryView()

@property (nonatomic, strong) UIScrollView   * scrollView; // 所有标签所在的scrollview
@property (nonatomic, strong) NSArray        * itemTitles; // 所有标签的标题
@property (nonatomic, strong) NSMutableArray * items; // 所有标签
@property (nonatomic, strong) JMCategoryItem * selectedItem; // 当前选中的标签
@property (nonatomic, strong) UIButton       * addCategoryBtn; // 添加分类标签按钮

@end

@implementation JMCategoryView

+ (instancetype)categoryViewWithItemTitles:(NSArray *)itemTiltes
{
    return [[JMCategoryView alloc] initWithItemTitles:itemTiltes];
}

+ (CGFloat)height
{
    return kItemH;
}

- (instancetype)initWithItemTitles:(NSArray *)itemTiltes
{
    if (self = [super init]) {
        // 0.数组
        _itemTitles = itemTiltes;
        self.backgroundColor = kBackgroundColor;
        _items = [NSMutableArray array];
        
        // 1.添加add按钮
        UIButton* addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundColor:kAddBtnBgColor];
        [addBtn setTitle:@"＋" forState:UIControlStateNormal];
        [addBtn setTitleColor:kAddBtnTitleColor forState:UIControlStateNormal];
        [self addSubview:addBtn];
        
        [addBtn addTarget:self action:@selector(clickAddItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_height);
            make.top.bottom.right.equalTo(self);
        }];
        self.addCategoryBtn = addBtn;
        
        // 2.添加scrollView
        UIScrollView* scrollView = [[UIScrollView alloc] init];
        scrollView.contentInset = UIEdgeInsetsMake(0, kScrollLeftInset, 0, 0);
        scrollView.backgroundColor = kScrollViewBg;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(kMargin, 0, 0, 0));
            make.right.equalTo(addBtn.mas_left);
        }];
        self.scrollView = scrollView;
        
        // 3.添加item
        [self addItems];
    }
    
    return self;
}

- (void)clickAddItem:(JMCategoryItem*)sender
{
    if ([_delegate respondsToSelector:@selector(clickedAddItemButton)]) {
        [_delegate clickedAddItemButton];
    }
}

- (void)addItems
{
    NSInteger itemCount = _itemTitles.count;

    for (int i=0; i<itemCount; i++) {
        // 1.创建item
        JMCategoryItem* item = [JMCategoryItem itemWithTitle:_itemTitles[i]];
        item.tag = i;
        [self.scrollView addSubview:item];
        
        // 2.添加约束
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(kItemW * i);
            make.top.bottom.height.equalTo(self.scrollView);
            make.width.equalTo([NSNumber numberWithInt:kItemW]);
        }];
        if (i == itemCount - 1) { // 判断是否为最后一个item
            [item mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.scrollView);
            }];
        }
        
        // 3.添加点击事件
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) { // 选中第一个
            _selectedItem = item;
        }
        
        [_items addObject:item]; // 记录着每个item
    }
    
    // 对第一个item发送点击事件
    [self clickItem:_selectedItem];
}

- (void)clickItem:(JMCategoryItem*)item
{
    // 1.获得tag
    NSInteger fromIndex = _selectedItem.tag;
    NSInteger toIndex = item.tag;
    
    // 2.将已选择的取消
    [self click:item];
    
    // 3.通知代理
    if ([_delegate respondsToSelector:@selector(categoryView:selectedItemFromIndex:to:)]) {
        [_delegate categoryView:self selectedItemFromIndex:fromIndex to:toIndex];
    }
}

- (void)click:(JMCategoryItem*)item
{
    // 1.获得tag
    NSInteger fromIndex = _selectedItem.tag;
    NSInteger toIndex = item.tag;
    
    // 2.将已选择的取消，选择新的item
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    // 3.滚动视图
    if (toIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(-kScrollLeftInset, 0) animated:YES];
    } else {
        // 判断横向是否滚动到最右端
        
        // 点击当前选中item右边的item
        int scrollViewWidth = kMainScreenWidth - kItemH;
        int maxIndex = ceil((self.scrollView.contentSize.width - scrollViewWidth)/kItemW);
        if (self.scrollView.contentOffset.x < self.scrollView.contentSize.width - scrollViewWidth) {
            if (toIndex <= maxIndex) { // 点击右边的item，左移一个位置
                [self.scrollView setContentOffset:CGPointMake(kItemW * (toIndex - 1), 0) animated:YES];
            } else { // 滚动到最右边
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - scrollViewWidth, 0) animated:YES];
            }
        }
        
        // 点击当前选中item左边的item
        if (toIndex < fromIndex && toIndex > maxIndex) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - scrollViewWidth, 0) animated:YES];
        } else if (toIndex < fromIndex) {
            [self.scrollView setContentOffset:CGPointMake(kItemW * (toIndex - 1), 0) animated:YES];
        }
    }
}

- (void)setCategoryViewSelectedIndex:(NSInteger)index
{
    if (index<0 || index>=_items.count) {
        return;
    }
    
    [self click:_items[index]]; // 发送点击事件
}

@end




