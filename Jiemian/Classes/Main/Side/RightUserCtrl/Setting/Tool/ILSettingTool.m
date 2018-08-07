//
//  ILSettingTool.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#define ILUserDefaults [NSUserDefaults standardUserDefaults]

#import "ILSettingTool.h"

@implementation ILSettingTool
+ (id)objectForKey:(NSString *)defaultName
{
    return [ILUserDefaults objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [ILUserDefaults setObject:value forKey:defaultName];
    [ILUserDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [ILUserDefaults boolForKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [ILUserDefaults setBool:value forKey:defaultName];
    [ILUserDefaults synchronize];
}
@end
