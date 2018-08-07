//
//  ILAboutViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILAboutViewController.h"
#import "ILAboutHeaderView.h"
//#import "ILAppInfo.h"

@interface ILAboutViewController ()
{
    UIWebView *_webView;
}
@end

@implementation ILAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    self.title = @"关于";
    
    // 1.1 评分支持
    ILSettingArrowItem *mark = [ILSettingArrowItem itemWithTitle:@"评分支持"];
    mark.operation = ^{
        UIApplication *app = [UIApplication sharedApplication];
        NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8", @"appid"];
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }
    };
    
    // 1.2 客服电话
    __unsafe_unretained ILAboutViewController *about = self;
    ILSettingArrowItem *phone = [ILSettingArrowItem itemWithTitle:@"客服电话"];
    phone.subtitle = @"020-83568090";
    phone.operation = ^{
        // 打电话
//        NSURL *url = [NSURL URLWithString:@"tel://020-10010"];
//        [[UIApplication sharedApplication] openURL:url];
        [about->_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://020-10010"]]];

    };
    
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = @[mark, phone];
    [_allGroups addObject:group];
    
    // 2.设置表格的头部控件
    self.tableView.tableHeaderView = [ILAboutHeaderView headerView];
//    self.tableView.scrollEnabled = NO;
}

@end
