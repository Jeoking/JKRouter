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
 *  URL的theme
 */
@property (nonatomic, copy) NSString *scheme;

/**
 *  对应vc名称
 */
@property (nonatomic, copy) NSString *vcName;

/**
 *  获取vcMap的键值
 */
@property (nonatomic, copy) NSString *vcMapKey;

/**
 *  回调
 */
@property (nonatomic, copy) HandlerBlock handlerBlock;

@end
