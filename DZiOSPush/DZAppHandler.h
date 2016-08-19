//
//  DZAppHandle.h
//  ModuleDemo
//
//  Created by jaunce on 16/5/16.
//  Copyright © 2016年 APICloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DZAppHandler : NSObject <UIApplicationDelegate>

+ (DZAppHandler *)sharedHander;

//记录app启动时候的launchOptions
@property (nonatomic,strong) NSDictionary *launchOptions;

@end
