//
//  ExampleWKWebViewController.m
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 1/13/14.
//  Copyright (c) 2014 Marcus Westin. All rights reserved.
//

#import "ExampleWKWebViewController.h"
#import "WebJsonDiffView.h"
#import "WebJsonDiffManager.h"

@implementation ExampleWKWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    WebJsonDiffView *diffView = [WebJsonDiffManager sharedInstance].jsonDiffView;
    diffView.frame = CGRectMake(0, 0, 100, 100);
    
    [self.view addSubview:diffView];
    [self renderButtons:diffView];
}

- (void)renderButtons:(WebJsonDiffView*)webView {
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
    [[WebJsonDiffManager sharedInstance] callData:@{@"left": @{ @"a": @1, @"b": @[@1] , @"d": @"2", @"f": @"1111"}, @"right":@{@"b": @2} } responseCallback:^(id responseData) {
        NSLog(@"testJavascriptHandler responded: %@", responseData);
    }];
}

- (void)jsonDiffHandler:(id)sender {
    [[WebJsonDiffManager sharedInstance] callData:@{@"left":@{@"a": @1}, @"right":@{@"b": @2} } responseCallback:^(id responseData) {
        NSLog(@"testJavascriptHandler responded: %@", responseData);
    }];
}

@end
