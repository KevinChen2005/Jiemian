//
//  JMMenuCellItem.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/16.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMMenuCellItem.h"
#import "JMLeftMenuItem.h"

#define kMargin 5
#define kIconMargin kMargin*2

#define kIconPlaceholder [UIImage imageNamed:@"channel_holder.png"]
#define kImageBg [UIImage imageNamed:@"background_hignlight.png"]

@interface JMMenuCellItem()

@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* slogan;

@end

@implementation JMMenuCellItem

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundImage:kImageBg forState:UIControlStateHighlighted];
        [self setBackgroundImage:kImageBg forState:UIControlStateSelected];
        
        // 1. icon
         UIImageView* icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([NSNumber numberWithInt:kIconMargin]);
            make.centerY.equalTo(self);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        self.icon = icon;
        
        // 2. title
        UILabel* title = [[UILabel alloc] init];
        title.font = [UIFont systemFontOfSize:14];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(kIconMargin);
            make.top.equalTo(self).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self.mas_centerY).offset(-kMargin);
        }];
        
        self.title = title;
        
        // 3. slogan
        UILabel* slogan = [[UILabel alloc] init];
        slogan.textColor = [UIColor grayColor];
        slogan.font = [UIFont systemFontOfSize:12];
        [self addSubview:slogan];
        [slogan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(kIconMargin);
            make.top.equalTo(title.mas_bottom).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self).offset(-kMargin);
        }];
        
        self.slogan = slogan;
        
    }
    
    return self;
}

- (void)setModel:(JMLeftMenuItem *)model
{
    _model = model;
    
    // 1. icon
    self.icon.hidden = NO;
    self.selected = NO;
    
    if (_model.type == 0) {
        self.selected = YES;
    }
    
    if ([_model.icon isEqualToString:@""]) { // 隐藏图标控件, 重新约束控件
        self.icon.hidden = YES;
    } else if ([[_model.icon substringToIndex:4] isEqualToString:@"http"]) { // 网络图片
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.icon] placeholderImage:kIconPlaceholder];
    } else { // 本地图标
        self.icon.image = [UIImage imageNamed:_model.icon];
    }
    
    // 2. title
    self.title.text = _model.title;
    
    // 3. slogan
    self.slogan.hidden = NO;
    self.slogan.text = _model.slogan;
    
    [self remakeConstraint];
}

- (void)setType:(JMMenuCellItemType)type
{
    _type  = type;
    
    [self remakeConstraint];
}

- (void)reAddView:(UIView*)view
{
    [view removeFromSuperview];
    [self addSubview:view];
}

- (void)remakeConstraint
{
    [self reAddView:self.icon];
    [self reAddView:self.title];
    [self reAddView:self.slogan];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([NSNumber numberWithInt:kIconMargin]);
        make.centerY.equalTo(self);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    if (_type == JMMenuCellItemTypeDefault) {
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(kIconMargin);
            make.top.equalTo(self).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self.mas_centerY).offset(-kMargin);
        }];
        
        [self.slogan mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(kIconMargin);
            make.top.equalTo(self.title.mas_bottom).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self).offset(-kMargin);
        }];

    } else if (_type == JMMenuCellItemTypeNoSlogan) {
        
        self.slogan.hidden = YES;
        
        [self.slogan mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(kIconMargin);
            make.top.equalTo(self).offset(kMargin);
            make.right.bottom.equalTo(self).offset(-kMargin);
        }];
        
    } else if (_type == JMMenuCellItemTypeNoIcon) {
        
        self.icon.hidden = YES;
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kIconMargin);
            make.top.equalTo(self).offset(kMargin);
            make.width.equalTo(@60);
            make.bottom.equalTo(self).offset(-kMargin);
        }];
        
        [self.slogan mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(kMargin);
            make.top.equalTo(self).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self).offset(-kMargin);
        }];
    }
}

@end
