//
//  DSLFMainViewController.m
//  DSLFGame
//
//  Created by 李峰 on 2019/2/26.
//  Copyright © 2019 dslf. All rights reserved.
//

#import "DSLFMainViewController.h"
#import <WebKit/WebKit.h>


@interface DSLFGameWebHandler : NSObject <WKScriptMessageHandler>
@end

@implementation DSLFGameWebHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    if (!_delegate) {
//        return;
//    }
//    NSError *error = nil;
//    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[message.body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
//    if (error != nil) {
//        NSLog(@"%@",[error localizedDescription]);
//    } else if (info == nil) {
//        NSLog(@"数据序列化出错");
//    } else {
//        [[[UIAlertView alloc] initWithTitle:@"测试" message:[NSString stringWithFormat:@"js调用了oc方法,传过来的数据为:%@",info] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
//    }
    
    NSString *info = message.body;
    
    [[[UIAlertView alloc] initWithTitle:@"测试" message:[NSString stringWithFormat:@"js调用了oc方法,传过来的数据为:%@",info] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    
}

@end



@interface DSLFMainViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) DSLFGameWebHandler *webHandler;
@end

@implementation DSLFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webHandler = [DSLFGameWebHandler new];
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    [configuration.userContentController addScriptMessageHandler:_webHandler name:@"DSLFTest"];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    //加载静态H5文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ceshi.html" withExtension:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [_webView evaluateJavaScript:@"ocTransferJs('oc调用js了啊啊啊啊')" completionHandler:^(id _Nullable da, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }];
    
}


@end
