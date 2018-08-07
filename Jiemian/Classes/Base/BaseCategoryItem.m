//
//  BaseCategoryItem.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "BaseCategoryItem.h"

#define kTitleColorNormal kColor(113, 113, 113)
#define kTitleColorSelected kColor(249, 0, 0)

#define kRedLineHeight 2

@interface BaseCategoryItem()

@property (nonatomic, strong) UIView* redLine; // 选中时下面的红线

@end

@implementation BaseCategoryItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        // 1.设置标题
        [self setTitle:title forState:UIControlStateNormal];
        
        // 2.设置字体颜色
        [self setTitleColor:kTitleColorNormal forState:UIControlStateNormal];
        [self setTitleColor:kTitleColorSelected forState:UIControlStateSelected];
        
        [self addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.选中时下面的红线
        _redLine = [[UIView alloc] init];
        _redLine.hidden = YES;
        _redLine.backgroundColor = kTitleColorSelected;
        [self addSubview:_redLine];
        
        [_redLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
            make.height.equalTo(@kRedLineHeight);
        }];
    }
    
    return self;
}

- (void)clickItem:(UIButton*)item
{
    item.selected = !item.selected;
}

- (void)setSelected:(BOOL)selected
{
    _redLine.hidden = !selected;
    
    [super setSelected:selected];
}

// 屏蔽选择时候高亮
- (void)setHighlighted:(BOOL)highlighted {}


@end
