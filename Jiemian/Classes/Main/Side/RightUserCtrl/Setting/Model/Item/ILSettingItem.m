//
//  ILSettingItem.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILSettingItem.h"

@implementation ILSettingItem
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ILSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (id)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
