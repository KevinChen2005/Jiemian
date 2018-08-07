//
//  BaseCategoryItem.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCategoryItem : UIButton

- (instancetype)initWithTitle:(NSString*)title;
+ (instancetype)itemWithTitle:(NSString*)title;

@end
