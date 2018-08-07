//
//  JMDetailController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/13.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMDetailController.h"

#define kDetailUrlWithID(newsID) [NSString stringWithFormat:@"http://appapi.jiemian.com/article/%@.json?appType=iPhone&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a", newsID]

@interface JMDetailController () 

@end

@implementation JMDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) safeSelf = self;
    
    NSString* url = kDetailUrlWithID(self.articleId);
    [HttpTool getWithURL:url success:^(id retObj) {
        
        if ([retObj[@"message"] isEqualToString: @"suss"]) {
            NSString* art_url = retObj[@"result"][@"art_url"];
            [safeSelf loadWebWithUrl:art_url];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


@end
