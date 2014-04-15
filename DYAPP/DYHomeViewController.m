//
//  DYFirstViewController.m
//  DYAPP
//
//  Created by dev on 13-12-18.
//  Copyright (c) 2013年 dy. All rights reserved.
//


#import "DYHomeViewController.h"
#import "XHFriendlyLoadingView.h"
@interface DYHomeViewController ()

@property (nonatomic, strong) XHFriendlyLoadingView *loadingView;
@end

@implementation DYHomeViewController



- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    self.webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    [self loadPage];
    
    //初始化refreshView，添加到webview 的 scrollView子视图中
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.webView.scrollView.bounds.size.height, self.webView.scrollView.frame.size.width, self.webView.scrollView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.webView.scrollView addSubview:_refreshHeaderView];
    }
    if(_loadingView == nil)
    {
        _loadingView = [[XHFriendlyLoadingView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.loadingView];    }
    
}

//加载网页
- (void)loadPage {
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dycfapp.dycf.cn/"]];
    [self.webView loadRequest:request];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _reloading = YES;
    if(!_isReload){
        [self.loadingView showFriendlyLoadingViewWithText:@"正在加载..." loadingAnimated:YES];
        
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _reloading = NO;
    if(!_isReload){
        
        [self.loadingView hideLoadingView];
    }
    _isReload = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"load page error:%@", [error description]);
    _reloading = NO;
    if(!_isReload){
        [self.loadingView showFriendlyLoadingViewWithText:@"加载失败，请返回检查网络。" loadingAnimated:NO];
    }
    _isReload = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

//refresh
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    _isReload = YES;
    [self.webView reload];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}

- (void)dealloc {
    self.webView = nil;
    self.loadingView = nil;
}
@end