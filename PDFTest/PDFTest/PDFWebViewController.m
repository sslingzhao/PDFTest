//
//  PDFWebViewController.m
//  PDFTest
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 ShineLing. All rights reserved.
//

#import "PDFWebViewController.h"

@interface PDFWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong)   UIWebView *webView;

@end

@implementation PDFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:self.webUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 设置缩放
    [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
    
    NSLog(@"正在加载webview");
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate= self;
    }
    return _webView;
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载完成");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
