//
//  JMNewsRst.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/11.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMNewsRst : NSObject

@property (nonatomic, assign) NSInteger rst_id;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* tags;
@property (nonatomic, copy) NSString* image_path;
@property (nonatomic, copy) NSString* z_image;
@property (nonatomic, copy) NSString* s_image;
@property (nonatomic, copy) NSString* m_image;
@property (nonatomic, copy) NSString* o_image;
@property (nonatomic, copy) NSString* l_image;
@property (nonatomic, copy) NSString* cl_image;
@property (nonatomic, copy) NSString* from;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, copy) NSString* published;
@property (nonatomic, assign) NSTimeInterval publishtime;
@property (nonatomic, copy) NSString* update_time;
@property (nonatomic, copy) NSString* keywords;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, assign) BOOL headline;
@property (nonatomic, assign) NSInteger quotation;
@property (nonatomic, assign) NSInteger t_recommend;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger collect;
@property (nonatomic, assign) NSInteger share;
@property (nonatomic, assign) NSInteger recommend;
@property (nonatomic, copy) NSString* audit;
@property (nonatomic, copy) NSString* ding;
@property (nonatomic, copy) NSString* hit;
@property (nonatomic, copy) NSString* day_hit;
@property (nonatomic, copy) NSString* week_hit;
@property (nonatomic, copy) NSString* month_hit;
@property (nonatomic, copy) NSString* sign;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* survey_id;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* smalltitle;

@property (nonatomic, copy) NSArray* author_list;

@property (nonatomic, copy) NSString* i_show_tpl;

@end
