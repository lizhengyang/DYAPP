//
//  XHFriendlyLoadingView.m
//  XHFriendlyLoadingView
//
//

#import "XHFriendlyLoadingView.h"

@interface XHFriendlyLoadingView () {
    
}

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *loadingLabel;



@end

@implementation XHFriendlyLoadingView



- (void)_setup {
    //self.backgroundColor = [UIColor colorWithRed:(244 / 255.f) green:(246 / 255.f) blue:(252 / 255.f) alpha:1.f];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.alpha = 0.;
    
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
    self.loadingLabel.alpha = 0.;
    self.loadingLabel.textColor = [UIColor grayColor];
    
    
    
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.loadingLabel];
}

+ (instancetype)shareFriendlyLoadingView {
    static XHFriendlyLoadingView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XHFriendlyLoadingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (void)dealloc {
    
    
    [self _stopActivityIndicatorView];
    self.activityIndicatorView = nil;
    self.loadingLabel = nil;
}

- (CGRect)_setpLoadingLabelForWidth:(CGFloat)width {
    CGRect loadingLabelFrame = self.loadingLabel.frame;
    //loadingLabelFrame.size.width = width;
    loadingLabelFrame.origin.x = 0;
    loadingLabelFrame.origin.y = CGRectGetHeight(self.bounds) / 2.0 - CGRectGetHeight(loadingLabelFrame) / 2.0;
    return loadingLabelFrame;
}

- (void)_stopActivityIndicatorView {
    if ([self.activityIndicatorView isAnimating]) {
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)_setupAllUIWithAlpha {
    self.loadingLabel.alpha = 0.;
    self.activityIndicatorView.alpha = 0.;
}

- (void)showFriendlyLoadingViewWithText:(NSString *)text loadingAnimated:(BOOL)animated {
    [self _setupAllUIWithAlpha];
    if (animated) {
        [self showLoadingAnimationWithText:text];
    } else {
        [self showPromptViewWithText:text];
    }
}

/**
 * 纯文字提示
 * @param promptString 要显示的提示字符串
 */
- (void)showPromptViewWithText:(NSString *)promptString {
    [self _stopActivityIndicatorView];
    
    // 只是显示一行文本
    self.loadingLabel.frame = [self _setpLoadingLabelForWidth:CGRectGetWidth(self.bounds)];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.text = promptString;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.activityIndicatorView.alpha = 0.;
        self.loadingLabel.alpha = 1.;
    } completion:^(BOOL finished) {
        
    }];
}


/**
 * 页面加载动画及信息提示
 * @param loadingString 要显示的提示字符串
 */
- (void)showLoadingAnimationWithText:(NSString *)loadingString {
    CGPoint activityIndicatorViewCentet = CGPointMake(CGRectGetWidth(self.bounds) / 2.0 * 2 / 2.8, CGRectGetHeight(self.bounds) / 2.0);
    self.activityIndicatorView.center = activityIndicatorViewCentet;
    [self.activityIndicatorView startAnimating];
    
    CGRect loadingLabelFrmae = [self _setpLoadingLabelForWidth:CGRectGetWidth(self.bounds) / 3];
    self.loadingLabel.textAlignment = NSTextAlignmentLeft;
    loadingLabelFrmae.origin.x = CGRectGetWidth(self.activityIndicatorView.frame) + self.activityIndicatorView.frame.origin.x + 8;
    loadingLabelFrmae.origin.y = CGRectGetHeight(self.bounds) / 2.0 - CGRectGetHeight(loadingLabelFrmae) / 2.0;
    self.loadingLabel.frame = loadingLabelFrmae;
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.text = loadingString;

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loadingLabel.alpha = 1.;
        self.activityIndicatorView.alpha = 1.;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
