//
//  JMChanelController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/10.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMChanelController.h"
#import "JMChannel.h"
#import "JMchanelHeader.h"
#import "JMChanelCell.h"

#define kCellID @"ChanelCellID"

#define kCategoryURL @"http://appapi.jiemian.com/cate/all.json?appType=iPhone&appid=AGcCMAhmB2YBOQ%3D%3D&version=3.1.2&token=6eadc9f537435da3c453f028ada5d54a"

@interface JMChanelController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* _allCategoryDatas;
    NSMutableArray* _myCategoryDatas;
    
    NSArray* _sourceData;
}

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation JMChanelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置UI
    self.title = @"频道管理";
    self.view.backgroundColor = kGlobalBG;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _allCategoryDatas = [NSMutableArray array];
    _myCategoryDatas = [NSMutableArray array];
    
    __weak typeof(self) safeSelf = self;
    
    // 2.添加header
    JMChanelHeader* header = [JMChanelHeader headerWithClickItemBlock:^(JMChanelHeaderItemIndex index) {
        [safeSelf clickItem:index];
    }];
    
    [self.view addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    // 3.添加tableView
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(header.mas_bottom);
    }];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMChanelCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellID];
    
    
    // 4.数据请求
    [HttpTool getWithURL:kCategoryURL success:^(id retObj) {
        NSLog(@"频道管理 - %@", retObj);
        if (retObj[@"result"]) {
            NSArray* array = [JMChannel mj_objectArrayWithKeyValuesArray:retObj[@"result"]];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_allCategoryDatas addObject:obj];
            }];
            
            [safeSelf seperateMyChanel];
            
            [safeSelf clickItem:JMChanelHeaderItemIndexAllChanel];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)seperateMyChanel
{
    [_allCategoryDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray* arr = obj;
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JMChannel* channel = obj;
                for (int i=0; i<_addedItemTitles.count; i++) {
                    if ([channel.name isEqualToString:_addedItemTitles[i]]) {
                        [_myCategoryDatas addObject:channel];
                    }
                }
            }];
        }
    }];
    
}

- (void)clickItem:(JMChanelHeaderItemIndex)index
{
    if (index == JMChanelHeaderItemIndexAllChanel) {
        _sourceData = _allCategoryDatas;
        [self.tableView reloadData];
    } else if (index == JMChanelHeaderItemIndexMyChanel) {
        _sourceData = [NSArray arrayWithObject:_myCategoryDatas];
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sourceData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sourceData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMChanelCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    JMChannel* c = _sourceData[indexPath.section][indexPath.row];
    cell.channel = c;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

@end

