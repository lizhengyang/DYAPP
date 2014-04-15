//
//  DYAppDelegate.h
//  DYAPP
//
//  Created by dev on 13-12-18.
//  Copyright (c) 2013年 dy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@end
