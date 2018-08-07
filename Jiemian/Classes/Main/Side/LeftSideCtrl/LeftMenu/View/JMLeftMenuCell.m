//
//  JMLeftMenuCell.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/16.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMLeftMenuCell.h"
#import "JMMenuCellItem.h"
#import "JMLeftMenuItem.h"
#import "JMLeftDetailController.h"

#define kMaxItemNum 3

@interface JMLeftMenuCell()

@property (nonatomic, strong) NSMutableArray* cellItems;
@property (nonatomic, strong) NSMutableArray* seperators;

@end

@implementation JMLeftMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellItems = [NSMutableArray arrayWithCapacity:kMaxItemNum];
        _seperators = [NSMutableArray arrayWithCapacity:kMaxItemNum];
        
        for (int i=0; i<kMaxItemNum; i++) {
            JMMenuCellItem* item = [[JMMenuCellItem alloc] init];
            [self.contentView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
            }];
            [_cellItems addObject:item];
            
            UIView* sep = [[UIView alloc] init];
            sep.backgroundColor = kColor(234, 234, 234);
            [self.contentView addSubview:sep];
            [sep mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
            }];
            [_seperators addObject:sep];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }
        
        [self hideAllSubviews];
    }
    
    return self;
}

- (void)hideAllSubviews
{
    for (int i=0; i<kMaxItemNum; i++) {
        UIButton* item = [_cellItems objectAtIndex:i];
        item.hidden = YES;
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
        UIView* sep = [_seperators objectAtIndex:i];
        sep.hidden = YES;
        [sep mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
}

- (void)setModels:(NSArray *)models
{
    _models = models;
    
    // 1. 初始化隐藏所有
    [self hideAllSubviews];
    
    // 2. 根据item的个数，设置约束
    [self makeConstraint];
}

- (void)makeConstraint
{
    NSInteger count = _models.count;
    count = MIN(_models.count, kMaxItemNum);
    
    if (count == 1) { // 1个item
        JMMenuCellItem* item = [_cellItems firstObject];
        item.hidden = NO;
        
        JMLeftMenuItem* model = [_models firstObject];
        if ([model.icon isEqualToString:@""]) {
            item.type = JMMenuCellItemTypeNoIcon;
        } else {
            item.type = JMMenuCellItemTypeDefault;
        }
        
        item.model = model;
        
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
    } else { // 多个item
        UIView* lastView = nil;
        for (int i=0; i<count; i++) {
            JMMenuCellItem* item = [_cellItems objectAtIndex:i];
            JMLeftMenuItem* model = [_models objectAtIndex:i];
            
            if ([model.icon isEqualToString:@""]) {
                item.type = JMMenuCellItemTypeNoIcon;
            } else {
                item.type = JMMenuCellItemTypeNoSlogan;
            }
            
            item.model = model;
            item.hidden = NO;
            
            UIView* seperator = [_seperators objectAtIndex:i];
            seperator.hidden = NO;
            
            if (i == 0) { // 第一个item
                [item mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(self.contentView);
                    make.width.equalTo(self.contentView.mas_width).multipliedBy((CGFloat)1/count);
                }];
                
                [seperator mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(item.mas_right);
                    make.width.equalTo(@1);
                    make.centerY.equalTo(self.contentView);
                    make.height.equalTo(self.contentView).multipliedBy(0.4);
                }];
                
                lastView = seperator;
            } else {
                [item mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastView.mas_right);
                    make.top.bottom.equalTo(self.contentView);
                    make.width.equalTo(self.contentView.mas_width).multipliedBy((CGFloat)1/count);
                }];
                
                [seperator mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(item.mas_right);
                    make.width.equalTo(@1);
                    make.centerY.equalTo(self.contentView);
                    make.height.equalTo(self.contentView).multipliedBy(0.4);
                }];
                
                lastView = seperator;
            }
        }
    }
}

- (void)clickItem:(JMMenuCellItem*)item
{
    [_owner hideWithAnimation:YES];
    
    if (item.model.type == 0) {
        
    } else {
        JMLeftDetailController* detailVC = [[JMLeftDetailController alloc] init];
        detailVC.item = item.model;
        
        UINavigationController* nav = nil;
        if ([_owner.parentVC isKindOfClass:[UINavigationController class]]) {
            nav = (UINavigationController*)_owner.parentVC;
        } else {
            nav = _owner.parentVC.navigationController;
        }
        [nav pushViewController:detailVC animated:YES];
    }
}

@end
