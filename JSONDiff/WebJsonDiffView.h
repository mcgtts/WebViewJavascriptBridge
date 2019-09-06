//
//  WebJsonDiffView.h
//  ExampleApp-iOS
//
//  Created by Chao Meng on 2019/9/5.
//  Copyright © 2019 Marcus Westin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WKWebViewJSBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebJsonDiffView : UIView<WKNavigationDelegate>

@property (nonatomic, strong) WKWebViewJSBridge *bridge;

@end

NS_ASSUME_NONNULL_END
