//
//  JKRouteVCMap.m
//  JKRouteDemo
//
//  Created by JayKing on 17/8/9.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "JKRouteVCMap.h"

@implementation JKRouteVCMap

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
