//
//  JMCategoryItem.m
//  TestDemo
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMCategoryItem.h"

#define kWidth  64
#define kHeight 32

#define kItemBackgroundColor kColor(248, 248, 248)

@implementation JMCategoryItem

+ (CGSize)size
{
    return CGSizeMake(kWidth, kHeight);
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithTitle:title]) {
        // 1.设置宽高
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
        self.backgroundColor = kItemBackgroundColor;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return self;
}

@end
