//
//  Updater.m
//  SQCourt
//
//  Created by Jack on 11/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "Updater.h"
#import "Macro.h"

@implementation Updater
- (BOOL) checkUpdate
{
    __block BOOL isOld = false;
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        __block NSString *latestVersion;
        dispatch_sync(concurrentQueue, ^{
            NSURL *url = [NSURL URLWithString:@"http://61.147.251.189/minterface/resources/ipa/SQCourt.plist"];
            NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfURL:url];
            NSArray *array = [dictionary objectForKey:@"items"];
            NSDictionary *tmpDic = [array objectAtIndex:0];
            NSDictionary *metadata = [tmpDic objectForKey:@"metadata"];
            
            latestVersion = [NSString stringWithFormat:@"%@", [metadata objectForKey: @"bundle-version"]];
            NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            // NSLog(@"bundle-version: %@", latestVersion);
            
            if (latestVersion!=nil && localVersion!=nil && ![latestVersion isEqualToString:@"(null)"]) {
                isOld = ![latestVersion isEqualToString:localVersion];
            }
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            /*show the image to the user here on the main queue*/
            if (isOld&&latestVersion!=nil) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"提示更新"
                                      message:@"点击确定以更新"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"确定",nil];
                [alert show];
            }
        });
    });
    return isOld;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSLog(@"in");
    if (buttonIndex==1) {
        NSString *textURL = @"http://61.147.251.189/minterface/resources/ipa/install.html";
        NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
        [[UIApplication sharedApplication] openURL:cleanURL];
    }
}

@end
