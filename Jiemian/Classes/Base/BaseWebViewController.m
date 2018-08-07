//
//  BaseWebViewController.m
//  Jiemian
//
//  Created by Kevin Chen on 16/4/17.
//  Copyright © 2016年 Kevin Chen. All rights reserved.
//

#import "BaseWebViewController.h"

@interface JMBackButton : UIButton
@end
@implementation JMBackButton
- (void)setHighlighted:(BOOL)highlighted {} // 禁用hignLighted状态
@end

@interface BaseWebViewController () <UIWebViewDelegate>
{
    NSTimer* _timer1;
    float _progressValue;
}

@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, strong) UIProgressView* progress;

@property (nonatomic, strong) UIButton* popBtn;

@end

@implementation BaseWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建webview
    UIWebView* webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.backgroundColor = kGlobalBG;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    self.webView = webView;
    
    // 2.创建进度条
    UIProgressView* progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progress.tintColor = kColor(249, 0, 0);
    [self.view addSubview:progress];
    self.progress = progress;
    [self.progress setProgress:0.0];
    
    // 3.更新约束
    [self updateConstraintForOrientation:[[UIDevice currentDevice] orientation]];

    // 4.左边导航栏按钮
    // 4.1 返回按钮
    JMBackButton* backBtn = [JMBackButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 12, 22);
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    // 4.2 关闭按钮
    JMBackButton* popBtn = [JMBackButton buttonWithType:UIButtonTypeSystem];
    [popBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    popBtn.frame = CGRectMake(0, 0, 30, 20);
    self.popBtn = popBtn;
    self.popBtn.hidden = YES;
    UIBarButtonItem* pop = [[UIBarButtonItem alloc] initWithCustomView:popBtn];
    
    self.navigationItem.leftBarButtonItems = @[back, pop];

}

- (void)backAction
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        
        self.popBtn.hidden = NO;
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)changeProgress
{
    if (_progressValue > 0.9) {
        _progressValue = _progressValue + 0.000001;
    } else if (_progressValue > 0.7) {
        _progressValue += 0.001;
    } else if (_progressValue >= 0.5) {
        _progressValue += 0.002;
    }
    
    [self.progress setProgress:_progressValue animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.progress.hidden = NO;
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _progressValue = 0.5;
    
     _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.webView.canGoBack) {
        self.popBtn.hidden = NO;
    }
    
    [self progressComplete];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self progressComplete];
}

- (void)progressComplete
{
    if (_timer1) {
        [_timer1 invalidate];
    }
    
    if (self.progress) {
        [self.progress setProgress:1.0 animated:YES];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(hideProgress) userInfo:nil repeats:NO];
}

- (void)hideProgress
{
    self.progress.hidden = YES;
    [self.progress setProgress:0.0];
}

- (void)loadWebWithUrl:(NSString*)url
{
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

- (void)loadWebWithHTMLString:(NSString*)content
{
    NSMutableString* html = [NSMutableString string];
    
    [html appendString:@"<html>"];
    [html appendString:@"<body>"];
    [html appendString:[NSString stringWithFormat:@"%@", content]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self progressComplete];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self updateConstraintForOrientation:UIDeviceOrientationLandscapeLeft];
    } else {
        [self updateConstraintForOrientation:UIDeviceOrientationPortrait];
    }
}

- (void)updateConstraintForOrientation:(UIDeviceOrientation)orientation
{
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) { // 横屏
        [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.width.equalTo(self.view);
            make.top.equalTo(self.webView).offset(self.navigationController.navigationBar.frame.size.height);
            make.height.equalTo(@1);
        }];
    } else {
        [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.width.equalTo(self.view);
            make.top.equalTo(self.webView).offset(self.navigationController.navigationBar.frame.size.height + 20.0);
            make.height.equalTo(@1);
        }];
    }
}

@end
