//
//  WKWebPageController.m
//  zuoyetiankong
//
//  Created by 林志威 on 2019/7/3.
//  Copyright © 2019 林志威. All rights reserved.
//

#import "WKWebPageController.h"
#import <WebKit/WebKit.h>
#import "WebViewInjector.h"
#import "BCBFloatButton.h"


@interface WKWebPageController ()<WKNavigationDelegate,WKUIDelegate, JsCoadjutantDelegate, BCBFloatButtonDelegate>
@property (nonatomic) WKWebView *webView;
@property (nonatomic) WebViewInjector *injector;
@property (nonatomic) BCBFloatButton *floatButton;
@property (nonatomic) BOOL havePopVC;
@end

@implementation WKWebPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebView) name:kWS_InteriorNotification_RefrshWebView object:nil];
    [self prepareUI];
    //NSURL *url = [NSURL fileURLWithPath:self.webURL];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    if (self.webView) [self.webView stopLoading];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KWS_CloseWebView object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWS_InteriorNotification_JumpToAllTapeVC object:nil];
}

#pragma mark - Private Method
- (void)prepareUI {
    [self.view addSubview:self.webView];
//    self.floatButton = [[BCBFloatButton alloc] init];
//    [self.view addSubview:self.floatButton];
//    self.floatButton.delegate = self;
    
}

#pragma mark - 懒加载
- (WKWebView *)webView{
    if (!_webView) {
        self.injector = [[WebViewInjector alloc] init];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        [controller addScriptMessageHandler:self.injector name:@"WSJsFramework"];
        config.userContentController = controller;
        CGRect bounds = [ UIScreen mainScreen ].bounds;
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, statusBarHeight, bounds.size.width, bounds.size.height - statusBarHeight) configuration:config];
        [self.injector injectToWebView:_webView];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showLoadWithText:@"" addedTo:self.view isfullScreen:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}

#pragma mark -BCBFloatButtonDelegate
- (void)onClickHome {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)onClickRefresh {
    [self.webView reload];
}

#pragma mark - JsCoadjutantDelegate
//关闭sdk
- (void)coadjutantCloseWebViewWithJsHandlerBlock:(JsHandlerBlockBlock)block info:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        DLog(@"Web关闭成功==");
        block(@"Web关闭成功");
    }];
}

- (void)refreshWebView {
    [self.webView reload];
}



- (void)closeWebView {
    DLog(@"navigationController关闭成功==");
    [self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
