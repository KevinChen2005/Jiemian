//
//  JMNews.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/8.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//  一条新闻

#import <Foundation/Foundation.h>


@interface JMNews : NSObject

@property (nonatomic, copy) NSString* ids;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* tags;

@property (nonatomic, copy) NSString* z_image;

@property (nonatomic, copy) NSString* o_image;

@property (nonatomic, copy) NSString* summary;

@property (nonatomic, copy) NSString* published;

@property (nonatomic, copy) NSString* publishtime;

@property (nonatomic, copy) NSString* headline;

@property (nonatomic, copy) NSString* comment;

@property (nonatomic, copy) NSString* hit;

@property (nonatomic, copy) NSString* hit_status;

@property (nonatomic, copy) NSString* i_show_tpl;

@property (nonatomic, copy) NSString* author_name;

@property (nonatomic, copy) NSString* category;

@property (nonatomic, copy) NSString* active_state;

@end
