//
//  XHFriendlyLoadingView.h
//  XHFriendlyLoadingView
//
//

#import <UIKit/UIKit.h>



@interface XHFriendlyLoadingView : UIView


+ (instancetype)shareFriendlyLoadingView;

- (void)showFriendlyLoadingViewWithText:(NSString *)text loadingAnimated:(BOOL)animated;

/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView;


@end
