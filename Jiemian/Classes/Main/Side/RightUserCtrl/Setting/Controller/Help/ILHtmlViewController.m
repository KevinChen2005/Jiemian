//
//  ILHtmlViewController.m
//  01-ItcastLottery
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ILHtmlViewController.h"
#import "ILHtmlPage.h"

@interface ILHtmlViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation ILHtmlViewController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置标题
    self.title = _htmlPage.title;
    
    // 2.显示网页
    NSURL *url = [[NSBundle mainBundle] URLForResource:_htmlPage.html withExtension:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    // 3.设置左边的关闭
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - webview代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 添加圈圈
#warning 待写。。。。。
}

#pragma mark 任何js代码都只能在这个方法调用后执行
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 移出圈圈
    if (_htmlPage.ID) {
        NSString *js = [NSString stringWithFormat:@"window.location.href = '#%@';", _htmlPage.ID];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
}

@end
