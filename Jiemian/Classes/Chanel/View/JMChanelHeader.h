//
//  JMChanelHeader.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMChanelHeaderItemIndex) {
    JMChanelHeaderItemIndexAllChanel = 0,
    JMChanelHeaderItemIndexMyChanel
};

typedef void(^blockClickItem)(JMChanelHeaderItemIndex index);

@interface JMChanelHeader : UIView

@property (nonatomic, assign) JMChanelHeaderItemIndex index;

+ (instancetype)headerWithClickItemBlock:(blockClickItem)clickedItemBlock;

@end
