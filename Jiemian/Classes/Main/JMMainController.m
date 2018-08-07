//
//  JMMainController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/5/11.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "JMMainController.h"
#import "JMChanelController.h"
#import "JMNewsController.h"
#import "JMNewsView.h"
#import "JMLeftSideCtrl.h"
#import "JMUserCtrl.h"
#import "JMHomeController.h"

@interface JMMainController ()
{
    BOOL _isShowLeftmenu;
}

@property (nonatomic, strong) NSMutableArray* newsControllers;
@property (nonatomic, strong) JMChanelController* chanelVC;

@property (nonatomic, strong) JMLeftSideCtrl* leftSideView;
@property (nonatomic, strong) JMUserCtrl* userView;

@end

@implementation JMMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 0.初始化
    _newsControllers = [NSMutableArray array];
    _isShowLeftmenu = NO;
    
    // 1.设置界面
    [self buildUI];
    
    // 2.加载网络数据
    [self loadData];
}

- (void)buildUI
{
    // 1.标题
    self.title = @"界面";
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 2.左边按钮
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"more.png"] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    // 3.右边按钮
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"user.png"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(clickUser) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    NSNotificationCenter* notifiCenter = [NSNotificationCenter defaultCenter];
    [notifiCenter addObserver:self selector:@selector(showLeftNotification:) name:kNotificationShowLeftmenu object:nil];
}

- (void)showLeftNotification:(id)sender
{
    //    _isShowLeftmenu = YES;
    
    //    NSLog(@"showLeftNotification");
}

- (JMLeftSideCtrl *)leftSideView
{
    if (_leftSideView == nil) {
        _leftSideView = [[JMLeftSideCtrl alloc] initWithParentView:self.view.window];
    }
    
    return _leftSideView;
}

- (JMUserCtrl *)userView
{
    if (_userView == nil) {
        _userView = [[JMUserCtrl alloc] initWithParentView:self.view];
    }
    
    return _userView;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_isShowLeftmenu) {
        [self clickMore];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.userView hideWithAnimation:NO];
    
    if (_isShowLeftmenu) {
        _isShowLeftmenu = NO;
    } else {
        [self.leftSideView hideWithAnimation:NO];
    }
}

- (void)clickMore
{
    [self.leftSideView showWithAnimation:YES];
}

- (void)clickUser
{
    [self.userView showWithAnimation:YES];
}

- (void)loadData
{
    // 1.添加子控制器
    NSArray* titles = @[@"首页", @"我的", @"热读", @"最新", @"热评", @"商业", @"天下", @"图片", @"科技", @"正午", @"营销", @"军事", @"中国", @"财经", @"娱乐"];
    int count = titles.count;
    
    JMHomeController* vc = [[JMHomeController alloc] init];
    vc.title = titles[0];    
    [_newsControllers addObject:vc];
    
    for (int i=1; i<count; i++) {
        JMNewsController* vc = [[JMNewsController alloc] init];
        vc.title = titles[i];
        
        [_newsControllers addObject:vc];
    }
    
    // 2.创建频道管理控制器
    JMChanelController* chanelVC = [[JMChanelController alloc] init];
    chanelVC.addedItemTitles = titles;
    self.chanelVC = chanelVC;
    
    // 3.添加新闻视图
    JMNewsView* newsView = [JMNewsView newsViewWithSubControllers:_newsControllers];
    [self.view addSubview:newsView];
    
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    // 4.点击添加按钮的操作
    __weak typeof(self) weakSelf = self;
    newsView.clickedAddItemOperation = ^(){
        [weakSelf.navigationController pushViewController:_chanelVC animated:YES];
    };
}

- (void)dealloc
{
    NSLog(@"dealloc...");
}

@end
