//
//  DZAppHandle.m
//  ModuleDemo
//
//  Created by jaunce on 16/5/16.
//  Copyright © 2016年 APICloud. All rights reserved.
//

#import "DZAppHandler.h"
#import "UZAppDelegate.h"

@implementation DZAppHandler

+ (DZAppHandler *)sharedHander
{
    static DZAppHandler *sharedHander;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHander = [[DZAppHandler alloc] init];
    });
    return sharedHander;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.launchOptions = launchOptions;
    
    [theApp removeAppHandle:self];
    return YES;
}

@end
