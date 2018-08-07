//
//  BaseTableController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/8.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "BaseTableController.h"

@interface BaseTableController ()

@end

@implementation BaseTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置背景颜色
    self.view.backgroundColor = kGlobalBG;
    self.tableView.backgroundColor = kGlobalBG;
    
    _allDatas = [NSMutableArray array];
    
    // 2.集成刷新控件
    [self setIsAddHeaderRefresh:_isAddHeaderRefresh];
    [self setIsAddFooterRefresh:_isAddFooterRefresh];
    
    [self buildSeperator];
}

// 分割线顶格
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

// 分割线顶格
- (void)buildSeperator
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setIsAddHeaderRefresh:(BOOL)isAddHeaderRefresh
{
    _isAddHeaderRefresh = isAddHeaderRefresh;
    
    if (_isAddHeaderRefresh && self.tableView.mj_header == nil) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    }
}

- (void)setIsAddFooterRefresh:(BOOL)isAddFooterRefresh
{
    _isAddFooterRefresh = isAddFooterRefresh;
    
    if (_isAddFooterRefresh && self.tableView.mj_footer == nil) {
        MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
        footer.appearencePercentTriggerAutoRefresh = -20;
        self.tableView.mj_footer = footer;
        self.tableView.mj_footer.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDate* now = [NSDate date];
    NSDate* lastUpdatedDate = self.tableView.mj_header.lastUpdatedTime;
    NSTimeInterval timeInterval= [now timeIntervalSinceDate:lastUpdatedDate];
    if (timeInterval > 60.0 * 5 || _allDatas.count == 0) { // 刷新时间间隔判断(单位：秒)
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)loadNewDatas
{
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreDatas
{
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_allDatas[section]).count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
