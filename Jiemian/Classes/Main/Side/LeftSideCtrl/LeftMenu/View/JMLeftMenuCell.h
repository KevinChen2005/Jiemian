//
//  JMLeftMenuCell.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/16.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JMLeftSideCtrl.h"

@interface JMLeftMenuCell : UITableViewCell
{
    UIImageView* _icon;
    
}

@property (nonatomic, strong) NSArray* models;
@property (nonatomic, strong) JMLeftSideCtrl* owner;

@end
