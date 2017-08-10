# JKRouter
100行代码实现iOS统调功能

第一步：在AppDelegate里注册

JKRouter *router = [JKRouter globalRouter];

router.rootNC = (UINavigationController *)self.window.rootViewController;
    
[router registerRouterUrl:@"JKRouteDemo://ViewController" hander:^(UIViewController *vc, NSDictionary *params) {

        NSLog(@"回调成功====>%@", params);
        NSLog(@"VC====>%@", NSStringFromClass([vc class]));

}];

第二步：执行统跳

[JKRouter routeURLStr:[NSString stringWithFormat:@"%@://ViewController?key=hello&key2=haha”, RouteScheme] params:@{@"key3”:@“OK”}];

第三步：没了，下Demo看吧
