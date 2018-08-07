//
//  ILProductCell.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILProductCell.h"
#import "ILProduct.h"
#import <QuartzCore/QuartzCore.h>

// 类扩展
@interface ILProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@end

@implementation ILProductCell

+ (NSString *)xib
{
    return @"ILProductCell";
}

- (void)awakeFromNib
{
    _iconView.layer.cornerRadius = 8;
    // 让内部的所有图层都遵循父图层的边框来显示
    // 超出父图层边框的内容全部不显示（裁剪掉）
    _iconView.layer.masksToBounds = YES;

//    _iconView.clipsToBounds = YES;
}

- (void)setProduct:(ILProduct *)product
{
    _product = product;
    
    // 1.图标
    _iconView.image = [UIImage imageNamed:product.icon];
    
    // 2.标题
    _titleView.text = product.title;
}

@end
