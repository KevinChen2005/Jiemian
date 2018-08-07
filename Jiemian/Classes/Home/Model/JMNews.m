//
//  JMNews.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/8.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNews.h"

@implementation JMNews

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ids" : @"id",
             @"desc" : @"description"
             };
}

@end
