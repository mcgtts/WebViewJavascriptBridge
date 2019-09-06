//
//  WebJsonDiffManager.h
//  ExampleApp-iOS
//
//  Created by Chao Meng on 2019/9/5.
//  Copyright © 2019 Marcus Westin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebJsonDiffView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebJsonDiffManager : NSObject

@property (nonatomic, strong) WebJsonDiffView *jsonDiffView;

/**
 * 得到一个HYManager的单例对象
 * @return 单例对象
 */
+ (WebJsonDiffManager *)sharedInstance;

- (void)callData:(id)data responseCallback:(WVJBResponseCallback)responseCallback;

@end

NS_ASSUME_NONNULL_END
