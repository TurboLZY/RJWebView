//
//  JsHandler.m
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import "JsHandler.h"

void invokeCallback(WKWebView *webView, NSDictionary *fromJs, NSMutableDictionary *toJs) {
    NSString *callback = fromJs[@"callback"];
    if (!callback) {
        return;
    }
    toJs[@"id"] = fromJs[@"id"];
    toJs[@"action"] = fromJs[@"action"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:toJs options:0 error:nil];
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"%@(%@)", callback, resultString];
    [webView evaluateJavaScript:js completionHandler:nil];
    NSLog(@"js---------:%@",js);
}
