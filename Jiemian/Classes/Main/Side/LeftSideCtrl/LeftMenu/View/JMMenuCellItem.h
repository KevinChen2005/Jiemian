//
//  JMMenuCellItem.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/16.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMMenuCellItemType) {
    JMMenuCellItemTypeDefault = 0, // 含有图标，标题，标语
    JMMenuCellItemTypeNoIcon, // 没有图标，只有标题和标语
    JMMenuCellItemTypeNoSlogan // 没有标语，只有图标和标题
};

@class JMLeftMenuItem;

@interface JMMenuCellItem : UIButton

@property (nonatomic, strong) JMLeftMenuItem* model;
@property (nonatomic, assign) JMMenuCellItemType type;

@end
