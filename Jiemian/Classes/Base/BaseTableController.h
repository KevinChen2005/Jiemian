//
//  BaseTableController.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/8.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableController : UITableViewController
{
    NSMutableArray* _allDatas;
}

/**
 *  是否集成头部刷新
 */
@property (nonatomic, assign) BOOL isAddHeaderRefresh;

/**
 *  是否集成底部刷新
 */
@property (nonatomic, assign) BOOL isAddFooterRefresh;

@end
