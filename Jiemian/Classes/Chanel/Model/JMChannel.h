//
//  JMChannel.h
//  Jiemian
//
//  Created by Kevin Chen on 16/5/12.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMChannel : NSObject

/**
 *  分类标签标识
 */
@property (nonatomic, assign) NSInteger category_id;

/**
 *  分类标签名称
 */
@property (nonatomic, copy) NSString* name;

/**
 *  是否显示（用户添加到浏览页面）
 */
@property (nonatomic, copy) NSString* show;

/**
 *  分类标签对应请求数据的url
 */
@property (nonatomic, copy) NSString* url;

/**
 *  分类标签unistr
 */
@property (nonatomic, copy) NSString* unistr;

/**
 *  分类标签是否允许编辑
 */
@property (nonatomic, assign) BOOL isEdit;

/**
 *  分类标签对应英文名
 */
@property (nonatomic, copy) NSString* app_en_name;

@end
