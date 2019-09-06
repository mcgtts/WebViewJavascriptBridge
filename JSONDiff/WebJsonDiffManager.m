//
//  WebJsonDiffManager.m
//  ExampleApp-iOS
//
//  Created by Chao Meng on 2019/9/5.
//  Copyright © 2019 Marcus Westin. All rights reserved.
//

#import "WebJsonDiffManager.h"

@implementation WebJsonDiffManager

+ (WebJsonDiffManager *)sharedInstance
{
    static WebJsonDiffManager *SINGLETON = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[WebJsonDiffManager alloc] init];
    });
    return SINGLETON;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (WebJsonDiffView *)jsonDiffView
{
    if (!_jsonDiffView) {
        _jsonDiffView = [[WebJsonDiffView alloc] initWithFrame:CGRectZero];
    }
    
    return _jsonDiffView;
}

- (void)callData:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [_jsonDiffView.bridge callHandler:@"jsonDiffVisualHandler" data:data responseCallback:responseCallback];
}

@end
