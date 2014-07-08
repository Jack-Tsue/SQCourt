//
//  AppDelegate.h
//  TEST
//
//  Created by Jack on 24/2/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Updater.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) Updater *updater;
@property (strong, nonatomic) UIWindow *window;
@end
