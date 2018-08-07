//
//  JMLeftController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/14.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMLeftController.h"
#import "JMLeftMenuItem.h"
#import "JMLeftMenuChanel.h"
#import "JMLeftMenuCooperation.h"
#import "JMLeftMenuCell.h"

#define kMenuCellID @"kMenuCellID"
#define kLeftMenuUrl @"http://appapi.jiemian.com/cate/left_menu.json?appType=iPhone&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a"

#define kTextColor kColor(65, 65, 65)

@interface JMLeftController ()
{
    JMLeftMenuCooperation* _cooperation;
}

@end

@implementation JMLeftController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 20, 0);
    self.tableView.rowHeight = 60;
    
    self.tableView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
    self.tableView.backgroundColor = kColor(228, 228, 228);
    [self.tableView registerClass:[JMLeftMenuCell class] forCellReuseIdentifier:kMenuCellID];
    
    [HttpTool getWithURL:kLeftMenuUrl success:^(id retObj) {
        // 0.解析result
        id result = retObj[@"result"];
        
        // 1.解析channel
        NSMutableArray* arr = [NSMutableArray array];
        NSArray* channelArray = result[@"channel"];
        [channelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMLeftMenuChanel* channel = [JMLeftMenuChanel mj_objectWithKeyValues:obj];
            channel.rows = [JMLeftMenuItem mj_objectArrayWithKeyValuesArray:result[@"channel"][idx][@"rows"]];
            [arr addObject:channel];
        }];
        [_allDatas addObject:arr];
        
        // 2.解析cooperation
        _cooperation = [JMLeftMenuCooperation mj_objectWithKeyValues:result[@"cooperation"]];
        _cooperation.data = [JMLeftMenuItem mj_objectArrayWithKeyValuesArray:result[@"cooperation"][@"data"]];
        [_allDatas addObject:_cooperation.data];
        
        // 3.刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMLeftMenuCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuCellID forIndexPath:indexPath];
    NSArray* items = [self getItemArrayWithRowIndexPath:indexPath];
    
    cell.owner = _owner;
    cell.models = items; //[NSArray arrayWithObject:[items firstObject]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    
    [header setFont:[UIFont systemFontOfSize:13.0]];
    [header setTextAlignment:NSTextAlignmentCenter];
    [header setBackgroundColor:[UIColor clearColor]];
    [header setTextColor:kTextColor];
    
    if (section == 0) {
        header.text = @"——· 为独立思考人群服务 ·——";
    } else if (section == 1) {
        header.text = @"——· 战略合作 ·——";
    }
    return header;
}

- (NSArray*)getItemArrayWithRowIndexPath:(NSIndexPath *)indexPath
{
    NSArray* retArray = nil;
    if (indexPath.section == 0) {
        JMLeftMenuChanel* chanel = _allDatas[indexPath.section][indexPath.row];
        retArray = chanel.rows;
    } else if (indexPath.section == 1) {
        JMLeftMenuItem* item = _allDatas[indexPath.section][indexPath.row];
        retArray = @[item];
    }

    return retArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

@end
