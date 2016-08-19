//
//  UZModuleDemo.m
//  UZModule
//
//  Created by kenny on 14-3-5.
//  Copyright (c) 2014年 APICloud. All rights reserved.
//

#import "DZiOSPush.h"
#import "UZAppDelegate.h"
#import "NSDictionaryUtils.h"
#import "DZAppHandler.h"

@interface DZiOSPush ()<UIAlertViewDelegate,UIApplicationDelegate>

{
    NSInteger _cbId;//方法的回调id
}

@end

@implementation DZiOSPush

+ (void)launch {
    DZAppHandler *handler = [DZAppHandler sharedHander];
    [theApp addAppHandle:handler];
}

- (id)initWithUZWebView:(UZWebView *)webView_ {
    if (self = [super initWithUZWebView:webView_]) {
        [theApp addAppHandle:self];
    }
    return self;
}

- (void)dispose {
    [theApp removeAppHandle:self];
}

- (void)initialize:(NSDictionary *)paramDict {
    _cbId = [paramDict integerValueForKey:@"cbId" defaultValue:-1];
    
    NSDictionary *launchOptions = [DZAppHandler sharedHander].launchOptions;
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [self handleRemoteNotification:userInfo];
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSString *payload = userInfo[@"payload"];
    if (payload && _cbId >= 0) {
        [self sendResultEventWithCallbackId:_cbId dataDict:@{@"payload":payload} errDict:nil doDelete:NO];
    }
}


#pragma mark - UIApplicationDelegate

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //后台点击推送唤醒 <iOS7
    [self handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        //后台点击推送唤醒 >iOS7
        [self handleRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
