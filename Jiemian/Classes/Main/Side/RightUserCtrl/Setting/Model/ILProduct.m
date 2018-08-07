//
//  ILProduct.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILProduct.h"

@implementation ILProduct
+ (id)productWithDict:(NSDictionary *)dict
{
    ILProduct *p = [[self alloc] init];
    p.title = dict[@"title"];
    p.icon = dict[@"icon"];
    p.url = dict[@"url"];
    p.customUrl = dict[@"customUrl"];
    p.ID = dict[@"id"];
    return p;
}
@end
