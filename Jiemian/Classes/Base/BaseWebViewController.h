//
//  BaseWebViewController.h
//  Jiemian
//
//  Created by Kevin Chen on 16/4/17.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController

- (void)loadWebWithUrl:(NSString*)url;
- (void)loadWebWithHTMLString:(NSString*)content;

@end
