//
//  ILSettingCell.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ILSettingItem;
@interface ILSettingCell : UITableViewCell
@property (nonatomic, strong) ILSettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView;
@end
