//
//  ILShareViewController.m
//  01-ItcastLottery
//
//  Created by mj on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILShareViewController.h"

@interface ILShareViewController ()

@end

@implementation ILShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分享设置";
    
    // 1.1.新浪微博
    ILSettingArrowItem *weibo = [ILSettingArrowItem itemWithIcon:@"WeiboSina" title:@"新浪微博"];
    
    // 1.2.短信分享
    ILSettingArrowItem *sms = [ILSettingArrowItem itemWithIcon:@"SmsShare" title:@"短信分享"];
    
    // 1.3.邮件分享
    ILSettingArrowItem *mail = [ILSettingArrowItem itemWithIcon:@"MailShare" title:@"邮件分享"];
    
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = @[weibo, sms, mail];
    [_allGroups addObject:group];
}

@end
