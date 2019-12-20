//
//  JsHandler.h
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef void(^JsHandlerBlockBlock)(id data);

@protocol JsHandler

- (NSString *)action;
- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info;

@end

#pragma mark - 控制器协助handler的协议
@protocol JsCoadjutantDelegate

@optional
/**
 用户选择弹窗

 @param block 选择后结果回调给JsHandler
 @param info JsHandler收到的info
 */
- (void)coadjutantUserSelectActionFormJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info;


/**
 获取用户通讯录

 @param block 获取结果回调给JsHandler
 @param info JsHandler收到的info
 */
- (void)coadjutantGetContactsHandlerWithJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info;


/**
 刷新控制器view

 @param block 处理完回调给jshandler
 @param info jshandler收到的info
 */
- (void)coadjutantReloadViewWithJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info;


/**
 关闭SDK

 @param block 处理完回调给jshandler
 @param info jshandler收到的info
 */
- (void)coadjutantEndSDKWithJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info;


/**
 关闭webView
 
 @param block 处理完回调给jshandler
 @param info jshandler收到的info
 */
- (void)coadjutantCloseWebViewWithJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info;
@end

#pragma mark - 全局方法
extern void invokeCallback(WKWebView *webView, NSDictionary *fromJs, NSMutableDictionary *toJs);
