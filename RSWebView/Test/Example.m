//
//  Example.m
//  RSWebView
//
//  Created by rason on 16/3/21.
//  Copyright © 2016年 RasonWu. All rights reserved.
//

#import "Example.h"
#import "RSWebView.h"
#import "TesViewController.h"
#import "RSControllerTools.h"
#import "BBWebViewSSLProtocol.h"
#import <objc/runtime.h>
@implementation Example
+(void)load{
    [self loadMethod];
}
-(void)TestInitWithHtml{
    _webView.webSource = [[RSWebSource alloc]initWithHtml:@"<html><div>测试</div></html>" baseURL:@""];
}
-(void)TestWebSource的修改了useragent{
    [RSWebView setUserAgent:@"setUserAgent"];
    _webView.webSource = [[RSWebSource alloc]initWithUrl:@"http://www.baidu.com" method:@"POST" headers:nil body:nil];
}
-(void)TestWebSource的没有修改了useragent{
    _webView.webSource = [[RSWebSource alloc]initWithUrl:@"http://www.baidu.com" method:@"GET" headers:nil body:nil];
}
-(void)TestAlert{
    [_webView evaluateJavaScript:@"alert(3+2)" completionHandler:^(id  _Nonnull result, NSError * _Nonnull error) {
        NSLog(@"alert");
    }];
}
-(void)TestComfirm{
    [_webView evaluateJavaScript:@"confirm(\"是否确认\")" completionHandler:^(id  _Nonnull result, NSError * _Nonnull error) {
        NSLog(@"确认框返回值:%@",result);
    }];
    
}
-(void)TestPrompt{
    [_webView evaluateJavaScript:@"prompt(\"随便写点儿啥吧\",\"比如我叫啥\")" completionHandler:^(id  _Nonnull result, NSError * _Nonnull error) {
        NSLog(@"输入框返回值:%@",result);
    }];
}
-(void)TestLoad_JD_COM{
    _webView.delegate = self;
    _webView.closeProgress = true;
    _webView.closeProgress = false;
    NSString *urlString = @"http://www.jd.com";
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self doSomeThing:^{
        [_webView loadRequest:req];
    }];
}
-(void)TestGoBack{
    if(_webView.canGoBack)
        [_webView goBack];
}
-(void)Test调用JSEcho{
    [_webView callHandler:@"JS Echo" data:@"success"];
}
-(void)Test注册ObjCEcho方法到OC中{
    [_webView registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"registerHandlerLog: %@", data);
        responseCallback(data);
    }];
}
-(void)TestClickWebView_Button_Call_ObjCEcho{
    [_webView loadLocalFile:@"TestSetupWebViewJavascriptBridge.html"];
}
-(void)Test测试evaluateJavaScript{
    [_webView evaluateJavaScript:@"prompt(\"随便写点儿啥吧\",\"我是内容\")" completionHandler:^(id  _Nonnull result, NSError * _Nonnull error) {
        NSLog(@"evaluateJavaScript返回值:%@",result);
    }];
}
-(void)Test测试Viewport{
    //    webView = [self iniWebView];
    TesViewController *viewController = [[TesViewController alloc]
                                         init];
    
    // We are the delegate responsible for dismissing the modal view
    //    viewController.delegate = self;
    
    // Create a Navigation controller
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
    // show the navigation controller modally
    [self.viewController presentViewController:navController animated:NO completion:nil];
    
    //    webView = [self iniWebView];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //        [self doSomeThing:^{
        _webView = [[RSWebView alloc]initWithFrame:CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
        _webView.delegate = self;
        NSLog(@"%@",NSStringFromCGRect(_webView.frame));
        [viewController.view addSubview:_webView];
        _webView.delegate = self;
        NSString *urlString = @"http://www.jd.com";
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [self doSomeThing:^{
            [_webView loadRequest:req];
        }];
        //        }];
    });
}
-(void)Test测试SSL的忽略处理{
    [BBWebViewSSLProtocol addTrustedDomain:@"js.com"];
    //    webView = [self iniWebView];
    TesViewController *viewController = [[TesViewController alloc]
                                         init];
    
    // We are the delegate responsible for dismissing the modal view
    //    viewController.delegate = self;
    
    // Create a Navigation controller
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
    // show the navigation controller modally
    [self.viewController presentViewController:navController animated:NO completion:nil];
    
    //    webView = [self iniWebView];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //        [self doSomeThing:^{
        _webView = [[RSWebView alloc]initWithFrame:CGRectMake(0, 0, viewController.view.frame.size.width, viewController.view.frame.size.height)];
//        _webView.delegate = self;
        NSLog(@"%@",NSStringFromCGRect(_webView.frame));
        [viewController.view addSubview:_webView];
//        _webView.delegate = self;
        NSString *urlString = @"https://js.com/";
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [self doSomeThing:^{
            [_webView loadRequest:req];
        }];
        //        }];
    });
}
-(void)Test测试itunes_apple_com跳转{
    [self pushView];
    [self doSomeThing:^{
        _webView.delegate = self;
        NSString *urlString = @"https://itunes.apple.com/us/app/zhi-xing-huo-che-piao-12306gou/id651323845?mt=8";
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [self doSomeThing:^{
            [_webView loadRequest:req];
        }];
    }];
}
-(void)doSomeThing:(void (^)())block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        block();
    });
}
-(RSWebView *)iniWebView{
    _webView.delegate = self;
    if (_webView) {
        return _webView;
    }
    return _webView;
}
-(void)pushView{
    [self pushView:[self iniWebView]];
}
-(void)pushView:(UIView *)view{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [vc.view addSubview:view];
    [self.viewController.navigationController pushViewController:vc animated:NO];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%@",@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@",@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",@"didFailLoadWithError");
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");
}
@end
