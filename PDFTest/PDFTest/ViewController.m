//
//  ViewController.m
//  PDFTest
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 ShineLing. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

#import "PDFWebViewController.h"

#import "ReaderViewController.h"

#define PDF_FILE_PATH [[NSBundle mainBundle] pathForResource:@"git-cheatsheet" ofType:@"pdf"]
#define PDF_URL @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource, ReaderViewControllerDelegate>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *titleArray;
@property (nonatomic, assign)   BOOL isLocal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"打开方式";
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.titleArray = [NSMutableArray array];
    [self.titleArray addObject:@"UIWebView本地浏览"];
    [self.titleArray addObject:@"UIWebView在线浏览"];
    [self.titleArray addObject:@"QLPreviewController浏览"];
    [self.titleArray addObject:@"PDF Reader"];
    
    [self.view addSubview:self.tableView];
    
    
    
    
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = FlatWhite;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kCellId"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCellId" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: // 使用webview查看本地PDF文件
        {
            NSLog(@"webView");
            PDFWebViewController *pdfWebCtrl = [[PDFWebViewController alloc]init];
            pdfWebCtrl.webUrlString = PDF_FILE_PATH;
            [self.navigationController pushViewController:pdfWebCtrl animated:YES];
            break;
        }
        case 1: // 使用webview查看网络PDF文件
        {
            NSLog(@"webView");
            PDFWebViewController *pdfWebCtrl = [[PDFWebViewController alloc]init];
            pdfWebCtrl.webUrlString = PDF_URL;
            [self.navigationController pushViewController:pdfWebCtrl animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"本地预览");
            self.isLocal = YES;
            QLPreviewController *qlPreview = [[QLPreviewController alloc]init];
            qlPreview.dataSource = self; //需要打开的文件的信息要实现dataSource中的方法
            qlPreview.delegate = self;  //视图显示的控制
            qlPreview.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
//            [self.navigationController pushViewController:qlPreview animated:YES];
            
            [self presentViewController:qlPreview animated:YES completion:nil];
            break;
        }
        case 3:
        {
            NSLog(@"阅读器");
            ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:PDF_FILE_PATH password:nil];
            ReaderViewController *rvc = [[ReaderViewController alloc] initWithReaderDocument:doc];
            rvc.delegate = self;
            [self presentViewController:rvc animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    //    NSString *str = @"/Users/mac/Desktop/The\ Swift\ Programming\ Language\ v1.8.pdf";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"git-cheatsheet" ofType:@"pdf"];
    
    return [NSURL fileURLWithPath:path];
}

#pragma mark - ReaderViewControllerDelegate
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
