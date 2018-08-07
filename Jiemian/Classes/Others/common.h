//
//  common.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#ifndef common_h
#define common_h

#import "MJRefresh.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "HttpTool.h"
#import "CommTool.h"

#define kColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kGlobalBG kColor(246, 246, 246)

#define kMainScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kMainScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kNotificationShowLeftmenu @"kNotificationShowLeftmenu"

#define ILJson(jsonName) [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"#jsonName" ofType:nil]]

#define ILDeclareConstStr(name) extern const NSString* name;
#define ILDefineConstStr(name) const NSString* name = @"123";

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif /* common_h */
