//
//  ILHelpViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILHelpViewController.h"
#import "ILHtmlViewController.h"
#import "ILHtmlPage.h"
#import "JMNavigationController.h"

@interface ILHelpViewController ()
{
    NSMutableArray *_htmlPages;
}
@end

@implementation ILHelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"帮助";
    
    // 1.加载JSON----help.json
    NSArray *array = ILJson(help.json);
    
    // 2.便利数组，创建所有的item
    _htmlPages = [NSMutableArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        // 2.1.创建网页模型
        ILHtmlPage *hp = [ILHtmlPage htmlPageWithDict:dict];
        [_htmlPages addObject:hp];
        
        // 2.2.每一行cell对应的item
        ILSettingArrowItem *arrow = [ILSettingArrowItem itemWithTitle:hp.title];
        [items addObject:arrow];
    }
    
    // 3.添加一组
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = items;
    [_allGroups addObject:group];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.跳到html控制器
    ILHtmlViewController *htmlVc = [[ILHtmlViewController alloc] init];
    htmlVc.htmlPage = _htmlPages[indexPath.row];
    
    JMNavigationController *nav = [[JMNavigationController alloc] initWithRootViewController:htmlVc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
