//
//  JMHomeController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMHomeController.h"
#import "JMNewsSection.h"
#import "JMDetailController.h"
#import "JMNews.h"
#import "JMHomeCell.h"

#define kHomeCellID @"kHomeCellID"

#define kHomeURL(page) [NSString stringWithFormat:@"http://appapi.jiemian.com/cate/main.json?appType=iPhone&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a&page=%d", page]

@interface JMHomeController ()
{
    NSInteger _cuttentPage;
    NSInteger _totalPage;
}

@end

@implementation JMHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cuttentPage = 1;
    _totalPage = 0;
    
    self.isAddHeaderRefresh = YES;
    self.isAddFooterRefresh = YES;
    
    self.tableView.rowHeight = 95;
    [self.tableView registerClass:[JMHomeCell class] forCellReuseIdentifier:kHomeCellID];
}

- (void)loadNewDatas
{
    NSString * url = kHomeURL(1);
    //    NSLog(@"%@", url);
    
    [HttpTool getWithURL:url success:^(id retObj) {
        
        NSLog(@"%@", retObj);
        
        id rstArray = retObj[@"result"][@"anlist"];
        
        NSArray* arry = [JMNewsSection mj_objectArrayWithKeyValuesArray:rstArray];
        
        [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMNewsSection* newsSec = obj;
            
            if (rstArray[idx][@"al"] != nil) {
                newsSec.news = [JMNews mj_objectArrayWithKeyValuesArray:rstArray[idx][@"al"]];
                
            } else if (rstArray[idx][@"ar"] != nil) {
                JMNews* news = [JMNews mj_objectWithKeyValues:rstArray[idx][@"ar"]];
                newsSec.news = @[news];
            }
            
//            NSLog(@"----%@", ((JMNews*)[newsSec.news firstObject]).category);
            
            
        }];
        [_allDatas addObjectsFromArray:arry];
        
        [self.tableView reloadData];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [self.tableView.mj_header endRefreshing];
    
}

- (void)loadMoreDatas
{
    _cuttentPage++;
    
    NSString * url = kHomeURL(_cuttentPage);
        NSLog(@"%@", url);
    
    
    [HttpTool getWithURL:url success:^(id retObj) {
        id rstArray = retObj[@"result"][@"anlist"];
        _cuttentPage = [retObj[@"result"][@"page"] integerValue];
        _totalPage = [retObj[@"result"][@"pageCount"] integerValue];
        
        NSArray* arry = [JMNewsSection mj_objectArrayWithKeyValuesArray:rstArray];
        
        [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMNewsSection* newsSec = obj;
            
            if (rstArray[idx][@"al"] != nil) {
                newsSec.news = [JMNews mj_objectArrayWithKeyValuesArray:rstArray[idx][@"al"]];
                
            } else if (rstArray[idx][@"ar"] != nil) {
                JMNews* news = [JMNews mj_objectWithKeyValues:rstArray[idx][@"ar"]];
                newsSec.news = @[news];
            }
            
            //            NSLog(@"----%@", ((JMNews*)[newsSec.news firstObject]).category);
            
            
        }];
        
        
        [_allDatas addObjectsFromArray:arry];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    if (_cuttentPage == _totalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((JMNewsSection *)_allDatas[section]).news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMHomeCell* cell = [tableView dequeueReusableCellWithIdentifier:kHomeCellID forIndexPath:indexPath];
    
    JMNews* news = ((JMNewsSection *)_allDatas[indexPath.section]).news[indexPath.row];
    cell.news = news;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JMDetailController* detailVC = [[JMDetailController alloc] init];
    JMNews* news = ((JMNewsSection *)_allDatas[indexPath.section]).news[indexPath.row];
    detailVC.articleId = news.ids;
    
    // 为了获得JMHomeController
    UIViewController* vc = [CommTool getViewControllerOfView:self.view.superview];
    
    [vc.navigationController pushViewController:detailVC animated:YES];
}

@end
