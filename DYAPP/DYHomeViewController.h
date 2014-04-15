//
//  DYFirstViewController.h
//  DYAPP
//
//  Created by dev on 13-12-18.
//  Copyright (c) 2013年 dy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"

@interface DYHomeViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    //刷新标识，是否正在刷新过程中
    BOOL _reloading;
    
    //是否下拉刷新
    BOOL _isReload;
    
    
    
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
