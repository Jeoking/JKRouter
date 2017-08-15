//
//  JKRouter.m
//  JKRouteDemo
//
//  Created by JayKing on 17/8/9.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKRouter.h"

/**
 路由工具类
 */
@interface JKRouter ()

@property (strong, nonatomic) NSMutableDictionary *routerDic;

@end

@implementation JKRouter

static JKRouter* _singleRouter = nil;

+ (instancetype) globalRouter {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _singleRouter = [[self alloc] init];
    }) ;
    return _singleRouter;
}

- (instancetype)init
{
    if ((self = [super init])) {
        self.routerDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setRootNC:(UINavigationController *)nc {
    if (!nc || ![nc isKindOfClass:[UINavigationController class]]) {
        NSLog(@"请传入UIViewController类型！");
        return;
    }
    _rootNC = nc;
}

/**
 注册路由
 
 @param urlStr URL
 @param vcName VC名称
 @param handlerBlock 回调
 */
- (void)registerRouterUrl:(NSString *)urlStr vcName:(NSString *)vcName hander:(HandlerBlock)handlerBlock {
    //去掉空格
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *routerUrl = [NSURL URLWithString:urlStr];
    if (!routerUrl || !routerUrl.host) {
        NSLog(@"不是合法的URL");
        return;
    }
    //创建路由模型
    JKRouteVCMap *routeVCMap = [[JKRouteVCMap alloc] init];
    routeVCMap.vcMapKey = routerUrl.host;
    routeVCMap.scheme = routerUrl.scheme;
    routeVCMap.vcName = vcName;
    routeVCMap.handlerBlock = handlerBlock;
    //将注册的路由模型添加到全局字典
    self.routerDic[routeVCMap.vcMapKey] = routeVCMap;
}

/**
 注册路由

 @param scheme scheme 可为nil
 @param vcMapKey 对应键值
 @param vcName vc名称
 @param handlerBlock 回调
 */
- (void)registerRouterScheme:(NSString *)scheme vcMapKey:(NSString *)vcMapKey vcName:(NSString *)vcName hander:(HandlerBlock)handlerBlock {
    if (!vcName) {
        return;
    }
    if (!scheme) {
        scheme = RouteScheme;
    }
    //创建路由模型
    JKRouteVCMap *routeVCMap = [[JKRouteVCMap alloc] init];
    routeVCMap.vcName = vcName;
    routeVCMap.scheme = scheme;
    routeVCMap.vcMapKey = vcMapKey;
    routeVCMap.handlerBlock = handlerBlock;
    //将注册的路由模型添加到全局字典
    self.routerDic[vcMapKey] = routeVCMap;
}

+ (void)routeURL:(NSURL *)url {
    if (!url) {
        return;
    }
    [self routeURLStr:[url absoluteString]];
}

+ (void)routeURLStr:(NSString *)urlStr {
    if (!urlStr) {
        return;
    }
    [[JKRouter globalRouter] routeURLStr:urlStr params:nil];
}

+ (void)routeURLScheme:(NSString *)scheme vcMapKey:(NSString *)vcMapKey {
    [self routeURLScheme:scheme vcMapKey:vcMapKey params:nil];
}

+ (void)routeURLStr:(NSString *)urlStr params:(NSDictionary *)params {
    [[JKRouter globalRouter] routeURLStr:urlStr params:params];
}

+ (void)routeURLScheme:(NSString *)scheme vcMapKey:(NSString *)vcMapKey params:(NSDictionary *)params {
    if (!vcMapKey) {
        return;
    }
    if (!scheme) {
        scheme = RouteScheme;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@", scheme, vcMapKey];
    [[JKRouter globalRouter] routeURLStr:urlStr params:params];
}

/**
 执行路由

 @param urlStr 路径
 @param params 传参 可为空
 */
- (void)routeURLStr:(NSString *)urlStr params:(NSDictionary *)params {
    //去掉空格
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *routerUrl = [NSURL URLWithString:urlStr];
    if (!routerUrl || !routerUrl.host) {
        NSLog(@"不是合法的URL");
        return;
    }
    JKRouteVCMap *routeVCMap = [self.routerDic objectForKey:routerUrl.host];
    if (!routeVCMap) {
        NSLog(@"此路径还未注册!");
        return;
    }
    if (!self.rootNC) {
        NSLog(@"请先设置根控制器!");
        return;
    }
    
    Class class = NSClassFromString(routeVCMap.vcName);
    if (!class) {
        NSLog(@"类不存在!");
        return;
    }
    id object = [[class alloc] init];
    if (![object isKindOfClass:[UIViewController class]]) {
        NSLog(@"类型错误!");
        return;
    }
    UIViewController *vc = object;
    
    //跳转
    if ([routerUrl.scheme isEqualToString:RouteScheme]) {
        //跳转下一个界面 默认
        [self.rootNC pushViewController:vc animated:YES];
    } else if ([routerUrl.scheme isEqualToString:PopScheme]) {
        //返回
        NSInteger vcCount = self.rootNC.childViewControllers.count;
        if (vcCount > 1) {
            vc = [self.rootNC.childViewControllers objectAtIndex:vcCount - 2];
            [self.rootNC popViewControllerAnimated:YES];
        } else {
            vc = [self.rootNC.childViewControllers objectAtIndex:0];
        }
    } else if ([routerUrl.scheme isEqualToString:PopToRootScheme]) {
        //返回到根视图
        vc = [self.rootNC.childViewControllers objectAtIndex:0];
        [self.rootNC popToRootViewControllerAnimated:YES];
    } else if ([routerUrl.scheme isEqualToString:PopToVCScheme]) {
        //返回到指定视图
        UIViewController *directVC = nil;
        for (UIViewController *subVC in self.rootNC.childViewControllers) {
            if ([subVC isMemberOfClass:class]) {
                directVC = subVC;
                break;
            }
        }
        if (directVC) {
            vc = directVC;
            [self.rootNC popToViewController:directVC animated:YES];
        } else {
            NSLog(@"没有此子控制器!");
            return;
        }
    } else if ([routerUrl.scheme isEqualToString:PresentVCScheme]) {
        //弹出模态视图
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.rootNC presentViewController:nc animated:YES completion:^{
            
        }];
    } else {
        NSLog(@"传入Scheme不正确!");
        return;
    }
    
    //回调
    if (routeVCMap.handlerBlock) {
        NSMutableDictionary *dic = [self getQueryParams:routerUrl.query];
        if (params) {
            [dic addEntriesFromDictionary:params];
        }
        routeVCMap.handlerBlock(vc, dic);
    }
}

/**
 URL传参解析

 @param params URL传参字符串 如：key=value&key1=value1
 @return 参数字典
 */
- (NSMutableDictionary *)getQueryParams:(NSString *)params {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (!params) {
        return dic;
    }
    NSArray *paramArray = [params componentsSeparatedByString:@"&"];
    if (!paramArray || paramArray.count == 0) {
        return dic;
    }
    for (NSString *param in paramArray) {
        NSArray *keyValue = [param componentsSeparatedByString:@"="];
        [dic setObject:keyValue[1] forKey:keyValue[0]];
    }
    return dic;
}


@end
