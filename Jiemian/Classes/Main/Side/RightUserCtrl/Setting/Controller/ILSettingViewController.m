//
//  ILSettingViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILSettingViewController.h"
#import "ILPushNoticeViewController.h"
#import "ILShareViewController.h"
#import "ILAboutViewController.h"
#import "ILHelpViewController.h"
#import "ILProductsViewController.h"
//#import "ILAppInfo.h"

@interface ILSettingViewController () <UIAlertViewDelegate>
@end

@implementation ILSettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.第0组：3个
    [self add0SectionItems];
    
    // 2.第1组：6个
    [self add1SectionItems];
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems
{
    // 1.1.推送和提醒
    ILSettingArrowItem *push = [ILSettingArrowItem itemWithIcon:@"MorePush" title:@"推送和提醒"];
    push.showVCClass = [ILPushNoticeViewController class];
    // copy状态下的block（堆里面的block）会对里面所使用的外界变量 产生 强引用
//    __weak ILSettingViewController *setting = self;
//    push.operation = ^{
//        ILPushNoticeViewController *notice = [[ILPushNoticeViewController alloc] init];
//        [setting.navigationController pushViewController:notice animated:YES];
//    };
    
    // 1.2.摇一摇机选
    ILSettingSwitchItem *shake = [ILSettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
    shake.key = ILSettingShakeChoose;
    
    // 1.3.声音效果
    ILSettingSwitchItem *sound = [ILSettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
    sound.key = ILSettingSoundEffect;
    
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = @[push, shake, sound];
    [_allGroups addObject:group];
}

#pragma mark 添加第1组的模型数据
- (void)add1SectionItems
{
    // 2.1.检查新版本
    ILSettingArrowItem *update = [ILSettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
   __unsafe_unretained ILSettingViewController *setting = self;
    update.operation = ^{
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"目前已是最新版本了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测到新版本" message:@"版本新特性如下：\n1.修正了少数BUG\n2.增加了什么模块\n3.增强了用户体验" delegate:setting cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
        [alert show];
    };
    
    // 2.2.帮助
    ILSettingArrowItem *help = [ILSettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助"];
    help.showVCClass = [ILHelpViewController class];
    
    // 2.3.分享
    ILSettingArrowItem *share = [ILSettingArrowItem itemWithIcon:@"MoreShare" title:@"分享"];
    share.showVCClass = [ILShareViewController class];
    
    // 2.4.查看消息
    ILSettingArrowItem *msg = [ILSettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看消息"];
    msg.operation = ^{
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:@"itcastapp://cn.itcast.mjapp"]];
    };
    
    // 2.5.产品推荐
    ILSettingArrowItem *product = [ILSettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐"];
    product.showVCClass = [ILProductsViewController class];
    
    // 2.6.关于
    ILSettingArrowItem *about = [ILSettingArrowItem itemWithIcon:@"MoreAbout" title:@"关于"];
    about.showVCClass = [ILAboutViewController class];
    
    ILSettingGroup *group = [[ILSettingGroup alloc] init];
    group.items = @[update, help, share, msg, product, about];
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