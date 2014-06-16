//
//  AppDelegate.m
//  E1
//
//  Created by linchuang on 21/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "AppDelegate.h"
#import "Dropbox.h"
#import <MessageUI/MFMailComposeViewController.h>



//E-learner: dropbox
#define APP_KEY @"q1eu49vkznw36ah"
#define APP_SECRET @"vmq39oknrqohkk8"
//E-learner: dropbox

//exception report
#define exceptionReportPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/exceptionReports"]
//exception report


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //exception
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    //exception
    
    
    
    //dropbox initial code
    DBAccountManager *accountManager =
    [[DBAccountManager alloc] initWithAppKey:APP_KEY secret:APP_SECRET];
    [DBAccountManager setSharedManager:accountManager];
    //dropbox initial code
    
    //rotation
        
    
    
    
    
    //rotation
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation
{
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account)
    {
        NSLog(@"App linked successfully!");
        return YES;
    }
    return NO;
}

void uncaughtExceptionHandler(NSException *exception)
{
    
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *exceptionContent = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",
                     name,reason,[arr componentsJoinedByString:@"\n"]];

    //print on the Xcoder controller comandatory requirement
    NSLog(exceptionContent);
    
    /*
    //optional  store the information in this machine
    NSFileManager *fileManager= [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:exceptionReportPath])
    {
        [fileManager createDirectoryAtPath:exceptionReportPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *path = [exceptionReportPath stringByAppendingPathComponent:@"Exception.txt"];
        [exceptionContent writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    //optional process 2 mail the information to the programmer
    */
    
    NSString *urlStr_ForExceptionContent = [NSString stringWithFormat:@"mailto:jack.lin.0614@gmail.com?subject=bug report&body=感谢您的配合\n 错误详情:\n name:%@\nreason:%@\ncallstack:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    
    NSURL *url = [NSURL URLWithString:[urlStr_ForExceptionContent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];


}





@end
