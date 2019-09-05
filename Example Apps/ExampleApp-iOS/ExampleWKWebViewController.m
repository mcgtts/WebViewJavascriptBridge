//
//  ExampleWKWebViewController.m
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 1/13/14.
//  Copyright (c) 2014 Marcus Westin. All rights reserved.
//

#import "ExampleWKWebViewController.h"
#import "WKWebViewJSBridge.h"

@interface ExampleWKWebViewController ()

@property WKWebViewJSBridge* bridge;

@end

@implementation ExampleWKWebViewController

- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [WKWebViewJSBridge enableLogging];
    _bridge = [WKWebViewJSBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge callHandler:@"jsonDiffHandler" data:@{@"left":@{@"a": @1}, @"right":@{@"b": @2} } responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"json diff 2 测试" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    
    UIButton* jsonDiffButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jsonDiffButton setTitle:@"json diff 1 测试" forState:UIControlStateNormal];
    [jsonDiffButton addTarget:self action:@selector(jsonDiffHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:jsonDiffButton aboveSubview:webView];
    jsonDiffButton.frame = CGRectMake(110, 400, 100, 35);
    jsonDiffButton.titleLabel.font = font;
}

- (void)callHandler:(id)sender {
    [_bridge callHandler:@"jsonDiffHandler" data:@{@"left": @{ @"a": @1, @"b": @[@1] , @"d": @"2", @"f": @"1111"}, @"right":@{@"b": @2} } responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)jsonDiffHandler:(id)sender {
    [_bridge callHandler:@"jsonDiffHandler" data:@{@"left":@{@"a": @1}, @"right":@{@"b": @2} } responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(WKWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
    
}
@end
