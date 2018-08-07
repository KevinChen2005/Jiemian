//
//  ILHtmlPage.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILHtmlPage.h"

@implementation ILHtmlPage
+ (id)htmlPageWithDict:(NSDictionary *)dict
{
    ILHtmlPage *hp = [[self alloc] init];
    hp.title = dict[@"title"];
    hp.html = dict[@"html"];
    hp.ID = dict[@"id"];
    return hp;
}
@end
