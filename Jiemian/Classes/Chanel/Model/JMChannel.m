//
//  JMChannel.m
//  Jiemian
//
//  Created by Kevin Chen on 16/5/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMChannel.h"

@implementation JMChannel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"category_id": @"id" };
}

@end
