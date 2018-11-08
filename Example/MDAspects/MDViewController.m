//
//  MDViewController.m
//  MDAspects
//
//  Created by iyongjie@yeah.net on 11/01/2018.
//  Copyright (c) 2018 iyongjie@yeah.net. All rights reserved.
//

#import "MDViewController.h"  
#import "MDSecViewController.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 130, 30)];
    [btn addTarget:self action:@selector(instanceMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"捕获类方法" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(100, 200, 130, 30)];
    [btn1 addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

 
    
    
}

-(void)instanceMethod{
    MDSecViewController *sec = [MDSecViewController new];
    [self.navigationController pushViewController:sec animated:YES];
}

-(void)clickAction{
    [MDViewController hookClassMethod];
}
+(void)hookClassMethod{
    NSLog(@"我是类方法，hook我吧");
}

@end
