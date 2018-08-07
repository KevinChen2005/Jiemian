//
//  ILProductCell.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ILProduct;
@interface ILProductCell : UICollectionViewCell
+ (NSString *)xib;

@property (nonatomic, strong) ILProduct *product;
@end
