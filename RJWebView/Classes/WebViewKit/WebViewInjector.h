//
//  WebViewInjector.h
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "JsHandler.h"
@interface WebViewInjector : NSObject <WKScriptMessageHandler>
- (void)injectToWebView:(WKWebView *)webView;
@end
