//
//  JMUserController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMUserController.h"
#import "ILSettingViewController.h"
#import "ILPushNoticeViewController.h"
#import "ILShareViewController.h"
#import "ILAboutViewController.h"
#import "ILHelpViewController.h"
#import "ILProductsViewController.h"
//#import "ILAppInfo.h"
#import "JMUserHeader.h"
#import "ILAboutHeaderView.h"

@interface JMUserController () <UIAlertViewDelegate>
@end

@implementation JMUserController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    JMUserHeader* header = [JMUserHeader header];
    header.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 140);
    self.tableView.tableHeaderView = header;
   
    [self add0SectionItems];
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems
{
    
    // 1.消息
    ILSettingArrowItem *message = [ILSettingArrowItem itemWithIcon:@"message" title:@"消息"];
    
    // 2.面点
    ILSettingArrowItem *cake = [ILSettingArrowItem itemWithIcon:@"cake" title:@"面点"];
    
    // 3.爆料
    ILSettingArrowItem *news = [ILSettingArrowItem itemWithIcon:@"news" title:@"爆料"];
    
    // 4.收藏
    ILSettingArrowItem *collection = [ILSettingArrowItem itemWithIcon:@"collection" title:@"收藏"];
    
    // 5.订阅
    ILSettingArrowItem *rss = [ILSettingArrowItem itemWithIcon:@"rss" title:@"订阅"];
    
    // 6.搜索
    ILSettingArrowItem *search = [ILSettingArrowItem itemWithIcon:@"search" title:@"搜索"];
    
    // 7.离线阅读
    ILSettingArrowItem *download = [ILSettingArrowItem itemWithIcon:@"download" title:@"离线阅读"];
    
    // 8.扫一扫
    ILSettingArrowItem *scan = [ILSettingArrowItem itemWithIcon:@"scan" title:@"扫一扫"];
    
    // 9.设置
    ILSettingArrowItem *setting = [ILSettingArrowItem itemWithIcon:@"setting" title:@"设置"];
    
    // 10.无图模式
    ILSettingSwitchItem *noImage = [ILSettingSwitchItem itemWithIcon:nil title:@"无图模式"];
    
    // 11.夜间模式
    ILSettingSwitchItem *night = [ILSettingSwitchItem itemWithIcon:nil title:@"夜间模式"];
    
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = @[message, cake, news, collection, rss, search, download, scan, setting, noImage, night];
    [_allGroups addObject:group];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIApplication *app = [UIApplication sharedApplication];
        NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8", @"appid"];
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }
    }
}

@end
