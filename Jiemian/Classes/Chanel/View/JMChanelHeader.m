//
//  JMChanelHeader.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMChanelHeader.h"
#import "JMChanelHeaderItem.h"

#define kTextColor kColor(102, 102, 102)
#define kSeperatorColor kColor(237, 237, 237)
#define kMargin 13

#define kTextClickAllChanel @"你可以订阅或前往查看频道"
#define kTextClickMyChanel @"可拖动排序，“-”为取消订阅"


@interface JMChanelHeader()
{
    JMChanelHeaderItem* _selectedItem;
    blockClickItem _clickItemBlock;
}

@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, strong) UIView* seperatorView;

@end

@implementation JMChanelHeader

+ (instancetype)headerWithClickItemBlock:(blockClickItem)clickedItemBlock
{
    return [[JMChanelHeader alloc] initWithClickItemBlock:clickedItemBlock];
}

- (instancetype)initWithClickItemBlock:(blockClickItem)clickedItemBlock
{
    if (self = [super init]) {
        // 1.设置背景
        self.backgroundColor = kGlobalBG;
        
        // 2.添加textLabel
        UILabel* textLabel = [[UILabel alloc] init];
        textLabel.text = kTextClickAllChanel;
        textLabel.font = [UIFont systemFontOfSize:11.0];
        textLabel.textColor = kTextColor;
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.backgroundColor = kGlobalBG;
        [self addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self).offset(kMargin);
            make.top.equalTo(self).offset(kMargin);
            make.height.equalTo(@kMargin);
        }];
        self.textLabel = textLabel;
        
        // 3.添加按钮
        int i=0;
        
        JMChanelHeaderItem* itemAllChanel = [JMChanelHeaderItem itemWithTitle:@"所有频道"];
        itemAllChanel.tag = i;
        [self addSubview:itemAllChanel];
        [itemAllChanel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(_textLabel.mas_bottom).offset(kMargin);
            make.width.equalTo(self.mas_width).multipliedBy(0.5).offset(-1);
            make.bottom.equalTo(self);
        }];
        [itemAllChanel addTarget:self action:@selector(clickItem:) forControlEvents:(UIControlEventTouchUpInside)];
        
        itemAllChanel.selected = YES;
        _selectedItem = itemAllChanel;
        
        i++;
        JMChanelHeaderItem* itemMyChanel = [JMChanelHeaderItem itemWithTitle:@"我的频道"];
        itemMyChanel.tag = i;
        [self addSubview:itemMyChanel];
        [itemMyChanel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(_textLabel.mas_bottom).offset(kMargin);
            make.width.bottom.equalTo(itemAllChanel);
        }];
        [itemMyChanel addTarget:self action:@selector(clickItem:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 添加分割
        [self addSubview:self.seperatorView];
        [self.seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(itemAllChanel);
            make.left.equalTo(itemAllChanel.mas_right);
            make.right.equalTo(itemMyChanel.mas_left);
        }];
        
        // 4.赋值block
        _clickItemBlock = clickedItemBlock;
    }
    
    return self;
}

- (void)clickItem:(JMChanelHeaderItem*)item
{
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    
    if (item.tag == JMChanelHeaderItemIndexAllChanel) { // 点击了所有频道
        self.textLabel.text = kTextClickAllChanel;
    } else if (item.tag == JMChanelHeaderItemIndexMyChanel) { // 点击了我的频道
        self.textLabel.text = kTextClickMyChanel;
    }
    
    if (_clickItemBlock) {
        _clickItemBlock(item.tag);
    }
}

- (UIView *)seperatorView
{
    if (_seperatorView == nil) {
        UIView* seperatorView = [[UIView alloc] init];
        seperatorView.backgroundColor = [UIColor whiteColor];
        UIView* seperator = [[UIView alloc] init];
        seperator.backgroundColor = kSeperatorColor;
        [seperatorView addSubview:seperator];
        [seperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(seperatorView).offset(10);
            make.bottom.equalTo(seperatorView).offset(-10);
            make.center.equalTo(seperatorView);
            make.width.equalTo(@1);
        }];
        _seperatorView = seperatorView;
    }
    
    return _seperatorView;
}

@end
