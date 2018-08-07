//
//  ILHtmlViewController.h
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  展示项目中的所有HTML文件

#import <UIKit/UIKit.h>
@class ILHtmlPage;

@interface ILHtmlViewController : UIViewController
@property (nonatomic, strong) ILHtmlPage *htmlPage;
@end
