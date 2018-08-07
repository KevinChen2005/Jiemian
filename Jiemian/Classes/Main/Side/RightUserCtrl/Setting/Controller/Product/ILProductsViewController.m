//
//  ILProductsViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILProductsViewController.h"
#import "ILProduct.h"
#import "ILProductCell.h"

NSString * const ILId = @"cell";

@interface ILProductsViewController ()
{
    NSMutableArray *_products;
}
@end

@implementation ILProductsViewController

- (id)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置每一个各自的大小
    flow.itemSize = CGSizeMake(80, 80);
    
    // 水平方向上的间距 == 0
    flow.minimumInteritemSpacing = 0;
    
    // 垂直方向上的间距 ==
//    flow.minimumLineSpacing = 40;
    
    flow.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    return [self initWithCollectionViewLayout:flow];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"其他产品推荐";
    
    // 1.加载JSON
    NSArray *array = ILJson(product.json);
    
    // 2.创建产品模型
    _products = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ILProduct *p = [ILProduct productWithDict:dict];
        [_products addObject:p];
    }
    
    // 3.注册
    UINib *nib = [UINib nibWithNibName:[ILProductCell xib] bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ILId];
    self.collectionView.backgroundColor = kGlobalBG;
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ILProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ILId forIndexPath:indexPath];
    
    cell.product = _products[indexPath.item];
    
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ILProduct *p = _products[indexPath.item];
    NSURL *appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", p.customUrl, p.ID]];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    // 1.先判断能否打开软件
    if ([app canOpenURL:appUrl]) {
        [app openURL:appUrl];
    } else { // 2.不能打开，去appStore下载
        NSURL *downloadUrl = [NSURL URLWithString:p.url];
        if ([app canOpenURL:downloadUrl]) {
            [app openURL:downloadUrl];
        }
    }
}
@end
