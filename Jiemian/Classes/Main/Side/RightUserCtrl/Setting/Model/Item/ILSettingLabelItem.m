//
//  ILSettingLabelItem.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILSettingLabelItem.h"

@implementation ILSettingLabelItem

- (void)setText:(NSString *)text
{
    _text = text;
    
    // 归档
    [ILSettingTool setObject:text forKey:self.key];
}

- (void)setKey:(NSString *)key
{
    [super setKey:key];
    
    _text = [ILSettingTool objectForKey:key];
}
@end
