//
//  ILAboutHeaderView.m
//  01-ItcastLottery
//
//  Created by mj on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILAboutHeaderView.h"

@implementation ILAboutHeaderView

+ (id)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ILAboutHeaderView" owner:nil options:nil][0];
}
@end
