//
//  ILSettingSwitchItem.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILSettingSwitchItem.h"

@implementation ILSettingSwitchItem
- (void)setOff:(BOOL)off
{
    _off = off;
    
    [ILSettingTool setBool:off forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _off = [ILSettingTool boolForKey:key];
}
@end
