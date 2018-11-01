//
//  MDViewController.m
//  MDAspects
//
//  Created by iyongjie@yeah.net on 11/01/2018.
//  Copyright (c) 2018 iyongjie@yeah.net. All rights reserved.
//

#import "MDViewController.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"捕获实例方法" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 100, 30)];
    [btn addTarget:self action:@selector(instanceMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"捕获类方法" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(100, 200, 100, 30)];
    [btn1 addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];


}

-(void)instanceMethod{
    NSLog(@"实例方法执行了");
}

-(void)clickAction{
    [MDViewController hookclassMethod];
}
+(void)hookclassMethod{
    NSLog(@"类方法执行了");
}
@end
