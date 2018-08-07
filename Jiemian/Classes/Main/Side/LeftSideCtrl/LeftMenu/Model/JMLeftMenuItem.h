//
//  JMLeftMenuItem.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/15.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMLeftMenuItem : NSObject

@property (nonatomic, copy) NSString* icon;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* slogan;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* sort;
@property (nonatomic, copy) NSString* unistr;
@property (nonatomic, copy) NSString* id_item;
@property (nonatomic, copy) NSString* show;

/*
"icon": "channel_jm",
"title": "界面新闻",
"slogan": "500位CEO鼎力推荐",
"type": "0",
"url": "",
"sort": "",
"unistr": "",
"id": "0",
"show": ""
*/

@end
