//
//  JMNewsSection.m
//  Jiemian
//
//  Created by Kevin Chen on 16/5/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNewsSection.h"

@implementation JMNewsSection

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"id_sec" : @"id",
             @"news" : @"al"
             };
}

@end
