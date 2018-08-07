//
//  JMUserHeader.m
//  Jiemian
//
//  Created by Kevin Chen on 16/5/1.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMUserHeader.h"

@implementation JMUserHeader


+ (instancetype)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"JMUserHeader" owner:nil options:nil][0];
}

@end
