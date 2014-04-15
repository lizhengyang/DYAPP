//
//  DYINViewController.h
//  DYAPP
//
//  Created by lzy on 14-3-13.
//  Copyright (c) 2014年 dy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DYINViewController : UIViewController<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;

@property (strong, nonatomic) IBOutlet UIButton *iposBtn;

@property (strong, nonatomic) IBOutlet UIButton *mallBtn;




@end
