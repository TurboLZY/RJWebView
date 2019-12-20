//
//  WebViewInjector.m
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import "WebViewInjector.h"
#import "DefaultHandler.h"



#define SOURCE_APPLICATION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/*不应该全局变量，这样相当于单例，导致sdk多次调起里面的handler都是同一个对象，这样handler里面记录的数据就不对了。
NSMutableDictionary<NSString*, id<JsHandler>> *s_jsHandlers = nil;

void addJsHandler(id<JsHandler> handler) {
    [s_jsHandlers setObject:handler forKey:[handler action]];
}

void initHandlersIfNeed() {
    if (!s_jsHandlers) {
        s_jsHandlers = [[NSMutableDictionary alloc] initWithCapacity:10];
        // 每种action都有自己的handler
        addJsHandler(VerifyIdentity.new);
        addJsHandler(UserSelectHandler.new);
        addJsHandler(GetContactsHandler.new);
        addJsHandler(GetLocationHandler.new);
        addJsHandler(GetInitDataHandler.new);
    }
}
*/
@interface WebViewInjector ()<UIActionSheetDelegate>

@property (nonatomic) WKWebView *webView;
@property (nonatomic) NSMutableDictionary<NSString*, id<JsHandler>> *jsHandlers;


@end

@implementation WebViewInjector

- (void)injectToWebView:(WKWebView *)webView {
    self.webView = webView;
    //initHandlersIfNeed();
    [self initHandlersIfNeed];
}

- (void)addJsHandler:(id<JsHandler>)handler {
    [self.jsHandlers setObject:handler forKey:[handler action]];
}

- (void)initHandlersIfNeed {
    if (!self.jsHandlers) {
        self.jsHandlers = [[NSMutableDictionary alloc] initWithCapacity:10];
        // 每种action都有自己的handler
        
        
    }
}

#pragma mark - WKScriptMessageHandler methods
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *action = body[@"action"];
    id<JsHandler> handler = self.jsHandlers[action];
    if (!handler) {
        handler = [DefaultHandler sharedInstance];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:body];
    [handler handleJsFromWebView:self.webView info:dic];
    NSLog(@"Action:%@",action);
    

}




@end
