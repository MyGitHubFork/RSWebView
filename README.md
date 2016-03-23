# RSWebView
UIWebView和WKWebView的混合框架,UIWebView自动切换到WKWebView。
##支持情况说明：
* UIWebView在iOS8及以后自动切换到WKWebView
* 支持设置html, baseUrl
* 可注入js脚本
* 可修改WebView请求的userAgent
* 支持忽略ssl验证, 通过 `addTrustedDomain` 添加
* 支持js交互 [WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge)，有修改
* 支持进度条 [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress)，有修改
* 支持手势滑动后退，后退时显示上个页面截图（类似safari，wechat）
* 支持从网页打开其他app，需要判断scheme是否允许
* 处理 [WKWebView问题](https://github.com/ShingoFukuyama/WKWebViewTips/blob/master/README.md)  比如打开app store.
* WebView加载本地资源(html,css,js,image...)

##使用方法：
pod加入以下部分：
```
pod 'RSWebView', :git => 'git@github.com:air1120/RSWebView.git'
```
把UIWebView换成RSWebView即可,支持UIWebView的所有方法和代理不受影响。可以把RSWebView当做UIWebView使用。注意如果在使用RSWebView的ViewController中，如果需要实现了UIWebView的代理方法，也要对应实现WKWebView的代理方法。

###扩展功能：
#####修改userAgent
```
//使用之后，需要通过[RSWebView setUserAgent:nil];来恢复
+(void)setUserAgent:(NSString *)userAgent;
```
#####对于POST或GET的扩展请求，headers是字典类型，body是字典或字符串形式，设置即发送请求。
设置一：
```
_webView.webSource = [[RSWebSource alloc]initWithUrl:@"http://www.baidu.com" method:@"GET" headers:nil body:nil];
```
设置二：
```
_webView.webSource = [[RSWebSource alloc]initWithHtml:@"<html><div>测试</div></html>" baseURL:@""];
```
#####读取本地文件：
```
-(void)loadLocalFile:(NSString *)fileName baseURL:(NSString *)baseURL;
-(void)loadLocalFile:(NSString *)fileName;
```
WebViewJavascriptBridge的js交互部分：
```
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler;
- (void)callHandler:(NSString *)handlerName;
- (void)callHandler:(NSString *)handlerName data:(id)data;
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
```
