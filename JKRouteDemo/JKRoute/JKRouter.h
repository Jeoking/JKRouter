//
//  JKRouter.h
//  JKRouteDemo
//
//  Created by JayKing on 17/8/9.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRouteVCMap.h"

static NSString *RouteScheme = @"JKRouteDemo";               //跳转到下一个控制器
static NSString *PopScheme = @"JKPopScheme";                 //返回到上一个控制器
static NSString *PopToRootScheme = @"JKPopToRootScheme";     //返回到根控制器
static NSString *PopToVCScheme = @"JKPopToVCScheme";         //返回到指定控制器
static NSString *PresentVCScheme = @"JKPresentVCScheme";     //弹出模态视图

@interface JKRouter : NSObject

/**
 设置根控制器
 */
@property (strong, nonatomic) UINavigationController *rootNC;

/**
 单例模式

 @return self
 */
+ (instancetype) globalRouter;

/**
 注册路由

 @param urlStr URL
 @param handlerBlock 回调
 */
- (void)registerRouterUrl:(NSString *)urlStr hander:(HandlerBlock)handlerBlock;

/**
 执行路由

 @param url 路径
 */
+ (void)routeURL:(NSURL *)url;

+ (void)routeURLStr:(NSString *)urlStr;

+ (void)routeURLScheme:(NSString *)scheme vc:(NSString *)vc;

+ (void)routeURLStr:(NSString *)urlStr params:(NSDictionary *)params;

+ (void)routeURLScheme:(NSString *)scheme vc:(NSString *)vc params:(NSDictionary *)params;

@end
