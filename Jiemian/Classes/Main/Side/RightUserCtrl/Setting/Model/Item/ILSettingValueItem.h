//
//  ILSettingValueItem.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  需要存储数据的item都继承自它

#import "ILSettingItem.h"
#import "ILSettingTool.h"

@interface ILSettingValueItem : ILSettingItem
@property (nonatomic, copy) NSString *key; // 存储数据用的key
@end
