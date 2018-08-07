//
//  JMLeftDetailController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/17.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMLeftDetailController.h"
#import "JMLeftMenuItem.h"

@interface JMLeftDetailController ()

@end

@implementation JMLeftDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![_item.url isEqualToString:@""]) {
        [self loadWebWithUrl:_item.url];
    }
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:kNotificationShowLeftmenu object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    //创建一个消息对象
//    NSNotification * notice = [NSNotification notificationWithName:kNotificationShowLeftmenu object:nil userInfo:nil];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
//}

@end
