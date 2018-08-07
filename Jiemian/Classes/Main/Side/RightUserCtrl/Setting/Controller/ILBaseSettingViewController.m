//
//  ILBaseSettingViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILBaseSettingViewController.h"
#import "ILSettingCell.h"

const int ILCellSectionHeaderH = 25;

@interface ILBaseSettingViewController ()

@end

@implementation ILBaseSettingViewController

- (void)loadView
{
    _allGroups = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 设置背景
    tableView.backgroundView = nil;
    tableView.backgroundColor = kGlobalBG;
    
    // group状态下，sectionFooterHeight和sectionHeaderHeight是有值的
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = ILCellSectionHeaderH;
    
    // 在tableView初始化的时候设置contentInset
    // 在tableView展示完数据的时候给contentInset.top增加64的值
    if (iOS7) {
        tableView.contentInset = UIEdgeInsetsMake(ILCellSectionHeaderH - 35, 0, 0, 0);
    }
    
    // 隐藏分隔线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view = tableView;
    
    _tableView = tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ILSettingGroup *group = _allGroups[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    ILSettingCell *cell = [ILSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ILSettingItem）
    ILSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 0.取出这行对应的模型
    ILSettingGroup *group = _allGroups[indexPath.section];
    ILSettingItem *item = group.items[indexPath.row];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
        return;
    }
    
    // 2.检测有没有要跳转的控制器
    if ([item isKindOfClass:[ILSettingArrowItem class]]) {
        ILSettingArrowItem *arrowItem = (ILSettingArrowItem *)item;
        if (arrowItem.showVCClass) {
            UIViewController *vc = [[arrowItem.showVCClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ILSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ILSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

@end
