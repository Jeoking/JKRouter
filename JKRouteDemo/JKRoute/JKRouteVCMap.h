//
//  JKRouteVCMap.h
//  JKRouteDemo
//
//  Created by JayKing on 17/8/9.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HandlerBlock)(UIViewController *vc, NSDictionary *params);

/**
 路由模型
 */
@interface JKRouteVCMap : NSObject

/**
 *  URL
 */
@property (nonatomic, copy) NSString *routeUrl;

/**
 *  URL的theme
 */
@property (nonatomic, copy) NSString *scheme;

/**
 *  URL的host 通常为控制器名称
 */
@property (nonatomic, copy) NSString *host;

/**
 *  回调
 */
@property (nonatomic, copy) HandlerBlock handlerBlock;

@end
