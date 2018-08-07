//
//  ILProduct.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILProduct : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *customUrl;
@property (nonatomic, copy) NSString *url;

+ (id)productWithDict:(NSDictionary *)dict;
@end
