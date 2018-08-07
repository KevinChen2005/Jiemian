//
//  JMNewsRst.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/11.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNewsRst.h"

@implementation JMNewsRst

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"rst_id" : @"id",
             @"desc" : @"description"
             };
}

@end
