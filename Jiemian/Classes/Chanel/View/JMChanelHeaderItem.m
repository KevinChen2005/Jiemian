//
//  JMChanelHeaderItem.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMChanelHeaderItem.h"

@implementation JMChanelHeaderItem

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithTitle:title]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    
    return self;
}

@end
