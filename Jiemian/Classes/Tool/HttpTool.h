//
//  HttpTool.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/7.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id retObj);
typedef void(^failureBlock)(NSError* error);

@interface HttpTool : NSObject

+ (void)getWithURL:(NSString*)url success:(successBlock)success failure:(failureBlock)failure;
+ (void)postWithURL:(NSString*)url params:(NSDictionary*)params success:(successBlock)success failure:(failureBlock)failure;

@end
