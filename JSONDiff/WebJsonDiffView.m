//
//  WebJsonDiffView.m
//  ExampleApp-iOS
//
//  Created by Chao Meng on 2019/9/5.
//  Copyright © 2019 Marcus Westin. All rights reserved.
//

#import "WebJsonDiffView.h"

@interface WebJsonDiffView ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebJsonDiffView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.bounds];
        _webView = webView;
        webView.navigationDelegate = self;
        [self addSubview:webView];
        [WKWebViewJSBridge enableLogging];
        _bridge = [WKWebViewJSBridge bridgeForWebView:webView];
        [_bridge setWebViewDelegate:self];
        
        [self loadWebPage:webView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [_webView setFrame:self.bounds];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}

- (void)loadWebPage:(WKWebView *)webView{
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"LogJsonDiffBundle" withExtension:@"bundle"];
    NSBundle *bundle = nil;
    if (bundleURL) {
        bundle = [NSBundle bundleWithURL:bundleURL];
    }else{
        bundle = [NSBundle mainBundle];
    }
    NSString* htmlPath =  [bundle pathForResource:@"JsonDiffApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

@end
