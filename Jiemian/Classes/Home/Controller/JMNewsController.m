//
//  JMNewsController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/6.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMNewsController.h"
#import "JMNewsRst.h"
#import "JMNewsCell.h"
#import "JMDetailController.h"

#define kCellID @"kCellID"

//#define kHomeURL @"http://appapi.jiemian.com/cate/main.json?appType=iPhone&appid=AGcCMAhmB2YBOQ%3D%3D&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a&page=1"

//#define kHomeURL @"http://appapi.jiemian.com/article/603292.json?appType=iPhone&appid=AGcCMAhmB2YBOQ%3D%3D&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a"


#define kHomeURL(page) [NSString stringWithFormat:@"http://appapi.jiemian.com/article/cate/181.json?appType=iPhone&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a&page=%d", page]

@interface JMNewsController ()
{
    NSInteger _cuttentPage;
    NSInteger _totalPage;
}

@end

@implementation JMNewsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cuttentPage = 1;
    _totalPage = 0;
    
    self.isAddHeaderRefresh = YES;
    self.isAddFooterRefresh = YES;
    
    self.tableView.rowHeight = 95;
    [self.tableView registerClass:[JMNewsCell class] forCellReuseIdentifier:kCellID];
}

- (void)loadNewDatas
{
    NSString * url = kHomeURL(1);
//    NSLog(@"%@", url);
    
    [HttpTool getWithURL:url success:^(id retObj) {
        id rstArray = retObj[@"result"][@"rst"];
        
        NSArray* arry = [JMNewsRst mj_objectArrayWithKeyValuesArray:rstArray];
        [_allDatas addObjectsFromArray:[NSArray arrayWithObject:arry]];
        
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
//    NSLog(@"%@", url);
    
    [HttpTool getWithURL:url success:^(id retObj) {
        id rstArray = retObj[@"result"][@"rst"];
        _cuttentPage = [retObj[@"result"][@"page"] integerValue];
        _totalPage = [retObj[@"result"][@"pageCount"] integerValue];
        
        NSArray* arry = [JMNewsRst mj_objectArrayWithKeyValuesArray:rstArray];
        [_allDatas[0] addObjectsFromArray:arry];
        
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMNewsCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    JMNewsRst* rst = _allDatas[indexPath.section][indexPath.row];
    cell.news = rst;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JMDetailController* detailVC = [[JMDetailController alloc] init];
    JMNewsRst* news = _allDatas[indexPath.section][indexPath.row];
    
    detailVC.articleId = [NSString stringWithFormat:@"%d", news.rst_id];
    
    // 为了获得JMHomeController
    UIViewController* vc = [CommTool getViewControllerOfView:self.view.superview];

    [vc.navigationController pushViewController:detailVC animated:YES];
}

@end
