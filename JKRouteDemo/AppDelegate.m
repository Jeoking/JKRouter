//
//  AppDelegate.m
//  JKRouteDemo
//
//  Created by JayKing on 17/8/9.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "JKRouter.h"
#import "ViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *mainVC = [[ViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = mainNC;
    [self.window makeKeyAndVisible];
    
    [self registerRoutes];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options
{
    [JKRouter routeURL:url];
    return YES;
}

- (void) registerRoutes {
    JKRouter *router = [JKRouter globalRouter];
    router.rootNC = (UINavigationController *)self.window.rootViewController;
    
    [router registerRouterUrl:@"JKRouteDemo://ViewController/view/sub" hander:^(UIViewController *vc, NSDictionary *params) {
        NSLog(@"回调成功====>%@", params);
        NSLog(@"VC====>%@", NSStringFromClass([vc class]));
    }];
    
    [router registerRouterUrl:@"JKRouteDemo://ViewController2/view/sub" hander:^(UIViewController *vc, NSDictionary *params) {
        NSLog(@"回调成功====>%@", params);
        NSLog(@"VC====>%@", NSStringFromClass([vc class]));
        
        ViewController2 *vc2 = (ViewController2 *)vc;
        vc2.param1 = params[@"key"];
        [vc2 getParams:params[@"key"]];
    }];
    
    [router registerRouterUrl:@"JKRouteDemo://ViewController3/view/sub" hander:^(UIViewController *vc, NSDictionary *params) {
        NSLog(@"回调成功====>%@", params);
        NSLog(@"VC====>%@", NSStringFromClass([vc class]));
    }];
    
    [router registerRouterUrl:@"JKRouteDemo://ViewController4/view/sub" hander:^(UIViewController *vc, NSDictionary *params) {
        NSLog(@"回调成功====>%@", params);
        NSLog(@"VC====>%@", NSStringFromClass([vc class]));
    }];
}

- (void)selectVC:(NSInteger)index {
//    [JKRouter globalRouter].rootVC = self.tab.selectVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
