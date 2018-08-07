//
//  JMNewsSection.h
//  Jiemian
//
//  Created by Kevin Chen on 16/5/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMNews.h"

@interface JMNewsSection : NSObject

@property (nonatomic, assign) NSInteger id_sec;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* show;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* unistr;
@property (nonatomic, copy) NSString* i_type;
@property (nonatomic, copy) NSString* i_show_tpl;
@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSArray* news; // "al"

@property (nonatomic, copy) NSString* cate;

@end


/*
"id": "",
"title": "快讯",
"show": "",
"url": "",
"unistr": "",
"i_type": "article",
"i_show_tpl": "kuaixun_tpl",
"name": "手机app2_首页_通告",

*/