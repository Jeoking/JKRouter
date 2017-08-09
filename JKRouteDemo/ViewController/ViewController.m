//
//  ViewController.m
//  RouteDemo
//
//  Created by JayKing on 17/8/4.
//  Copyright © 2017年 JayKing. All rights reserved.
//

#import "ViewController.h"
#import "JKRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First";
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
//    [JKRouter routeURLScheme:RouteScheme vc:@"ViewController2" params:@{@"king":@"Jay"}];
    NSURL *editPost = [NSURL URLWithString:@"JKRouteDemo://ViewController2?key=lalala"];
    if ([[UIApplication sharedApplication] canOpenURL:editPost]) {
        [[UIApplication sharedApplication] openURL:editPost];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
