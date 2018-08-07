//
//  HttpTool.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/7.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+ (void)getWithURL:(NSString *)url success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
