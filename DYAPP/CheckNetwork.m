//
//  CheckNetwork.m
//  DYAPP
//
//  Created by dev on 13-12-19.
//  Copyright (c) 2013年 dy. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
#import "DXAlertView.h"
@implementation CheckNetwork
+(NSString*)isExistenceNetwork
{
	BOOL isExistenceNetwork = TRUE;
    NSString *result=@"";
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.dycf.cn"];
    if([reach currentReachabilityStatus] == NotReachable){
        isExistenceNetwork=FALSE;
        result=@"没有可用的网络";
    
    }
    NSLog(@"====");

	if (!isExistenceNetwork) {
        
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"网络状态" contentText:@"没有可用的网络" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
	}

	return result;
}

@end
