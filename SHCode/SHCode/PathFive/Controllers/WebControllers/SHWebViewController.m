//
//  SHWebViewController.m
//  SHCode
//
//  Created by ios on 17/4/9.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHWebViewController.h"
#import <WebKit/WebKit.h>

@interface SHWebViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation SHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    
    
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    //进度条
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
}
// 只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    
    self.forwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

#pragma mark - 对象被销毁
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


#pragma mark - LifeCicle
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.contentView.bounds;
}


- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}

#pragma mark - Getters
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}

@end
