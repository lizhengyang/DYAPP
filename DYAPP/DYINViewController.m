//
//  DYINViewController.m
//  DYAPP
//
//  Created by lzy on 14-3-13.
//  Copyright (c) 2014年 dy. All rights reserved.
//

#import "DYINViewController.h"
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
@interface DYINViewController ()


@end



@implementation DYINViewController
@synthesize scrollView, slideImages;
@synthesize text;
@synthesize pageControl;
NSTimer *timer;




-(void)viewWillAppear:(BOOL)animated
{
   

    // 定时器 循环
    timer =  [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    // 初始化 scrollview
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
       self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, 200)];
    }else{
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    }
    
  
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    // 初始化 数组 并添加四张图片
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"ad1.gif"];
    [slideImages addObject:@"ad2.gif"];
    [slideImages addObject:@"ad3.gif"];
    [slideImages addObject:@"ad4.gif"];
    // 初始化 pagecontrol
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
         self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(220,200,100,18)]; // 初始化mypagecontrol
     }else{
          self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(220,130,100,18)]; // 初始化mypagecontrol
     }
    

    if (DEVICE_IS_IPHONE5) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(220,230,100,18)]; // 初始化mypagecontrol
   }

    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.view addSubview:pageControl];
    // 创建四个图片 imageview
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((320 * i) + 320, 0, 320, self.view.frame.size.height/3);
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height/3); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((320 * ([slideImages count] + 1)) , 0, 320, self.view.frame.size.height/3); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(320 * ([slideImages count] + 2), self.view.frame.size.height/3)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,self.view.frame.size.height/3) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

    if (DEVICE_IS_IPHONE5) {
         [self.iposBtn setFrame:(CGRectMake(28, 266, 122, 109))];
            [self.mallBtn setFrame:(CGRectMake(173, 266, 122, 109))];
    }
  
    //菜单
    [self.mallBtn addTarget:self action:@selector(mallButton:) forControlEvents: UIControlEventTouchUpInside];

}

-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
    [timer invalidate];
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * [slideImages count],0,320,130) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,130) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,130) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
  
    page++;
    page = page > 3 ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}

//菜单
- (void)mallButton:(id)sender
{
   
    NSURL*url =[NSURL URLWithString:@"http://mall.dycf.cn/"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resourcesadfsfs that can be recreated.
}
@end
