//
//  ILSettingself.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILSettingCell.h"
#import "ILSettingItem.h"
#import "ILSettingSwitchItem.h"
#import "ILSettingArrowItem.h"
#import "ILSettingLabelItem.h"

const int ILCellMargin = 10;

@interface ILSettingCell()
{
    UIImageView *_arrow;
    UISwitch *_switch;
    UILabel *_label;
    
    UIView *_divider;
}
@end

@implementation ILSettingCell

+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    ILSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[ILSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置背景
        [self setupBg];
        
        // 2.设置子控件属性
        [self setupSubviews];
        
        // 3.添加分隔线
        [self setupDivider];
    }
    return self;
}

#pragma mark 添加分隔线
- (void)setupDivider
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = kColor(200, 200, 200);
    // 不能在这里设置分隔线的x值（原因：cell没有具体的数据，里面的label就不知道最终的位置）
//    divider.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 1.5);
    [self.contentView addSubview:divider];
    _divider = divider;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    _divider.hidden = indexPath.row == 0;
}

#pragma mark 设置子控件属性
- (void)setupSubviews
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
}

#pragma mark 设置背景
- (void)setupBg
{
    // 1.默认
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor whiteColor];
//    self.backgroundView = bg;
//
//    // 2.选中
//    UIView *selectedBg = [[UIView alloc] init];
//    selectedBg.backgroundColor = kColor(237, 233, 218);
//    self.selectedBackgroundView = selectedBg;
}

- (void)setItem:(ILSettingItem *)item
{
    _item = item;
    
    // 设置数据
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    if ([item isKindOfClass:[ILSettingArrowItem class]]) {
        [self settingArrow];
    } else if ([item isKindOfClass:[ILSettingSwitchItem class]]) {
        [self settingSwitch];
    } else if ([item isKindOfClass:[ILSettingLabelItem class]]) {
        [self settingLabel];
    } else {
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

#pragma mark 当cell的宽高改变了就会调用
// 需要调节cell内部子控件的frame，在layoutSubviews方法最可靠\最有效
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 0.设置分隔线的位置
//    _divider.frame = CGRectMake(self.textLabel.frame.origin.x, 0, self.contentView.frame.size.width + 100, 1.2);
//    
//    if (iOS7) return;
//    
//    // 1.cell的frame
//    CGRect cellF = self.frame;
//    cellF.origin.x = -ILCellMargin;
//    CGFloat deltaW = ILCellMargin * 2;
//    cellF.size.width = [UIScreen mainScreen].bounds.size.width + deltaW;
//    self.frame = cellF;
//    
//    // 2.右边控件的frame
//    CGRect accessF = self.accessoryView.frame;
//    accessF.origin.x = cellF.size.width - accessF.size.width - deltaW;
//    self.accessoryView.frame = accessF;
}

#pragma mark 设置右边的文本标签
- (void)settingLabel
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, self.frame.size.height);
        _label.textAlignment = NSTextAlignmentRight;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = kColor(173, 69, 14);
        _label.font = [UIFont systemFontOfSize:13];
    }
    
    // 设置右边label的值
    ILSettingLabelItem *labelItem = (ILSettingLabelItem *)_item;
    _label.text = labelItem.text;
    
    // 右边显示开关
    self.accessoryView = _label;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark 设置右边的开关
- (void)settingSwitch
{
    if (_switch == nil) {
        _switch = [[UISwitch alloc] init];
        [_switch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    
    // 设置开关的状态
    ILSettingSwitchItem *switchItem = (ILSettingSwitchItem *)_item;
    _switch.on = !switchItem.off;
    
    // 右边显示开关
    self.accessoryView = _switch;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark 开关状态改变
- (void)switchChange
{
    ILSettingSwitchItem *switchItem = (ILSettingSwitchItem *)_item;
//    switchItem.off = !_switch.on;
}

#pragma mark 设置右边的箭头
- (void)settingArrow
{
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    
    // 右边显示箭头
    self.accessoryView = _arrow;
    // 用默认的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}
@end
