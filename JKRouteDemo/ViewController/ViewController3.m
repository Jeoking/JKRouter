//
//  ViewController.m
//  RouteDemo
//
//  Created by JayKing on 17/8/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "ViewController3.h"
#import "JKRouter.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Third";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [btn setTitle:@"JumpTo" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)jumpAction {
//    [JKRouter routeURLStr:[NSString stringWithFormat:@"%@://ViewController?key=jay&key2=king", RouteScheme] params:@{@"key3":@"win"}];
    
    [JKRouter routeURLStr:[NSString stringWithFormat:@"%@://ViewController4", RouteScheme] params:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
