//
//  ILHtmlPage.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "title" : "如何充值？",
 "html" : "help.html",
 "id" : "howtorecharge"
 */
@interface ILHtmlPage : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *ID;

+ (id)htmlPageWithDict:(NSDictionary *)dict;
@end
