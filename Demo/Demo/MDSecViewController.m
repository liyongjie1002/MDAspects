//
//  MDSecViewController.m
//  MDAspects_Example
//
//  Created by 李永杰 on 2018/11/9.
//  Copyright © 2018年 iyongjie@yeah.net. All rights reserved.
//

#import "MDSecViewController.h"
#import "MDViewController.h"
#import <objc/runtime.h>
@interface MDSecViewController ()

@end

@implementation MDSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 130, 30)];
    [btn addTarget:self action:@selector(instanceMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"MDViewController的类方法" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(100, 200, 240, 30)];
    [btn1 addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"带参数的实例方法" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(100, 300, 240, 30)];
    [btn2 addTarget:self action:@selector(clickInstance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"带参数的类方法" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setFrame:CGRectMake(100, 400, 240, 30)];
    [btn3 addTarget:self action:@selector(clickClass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}
-(void)instanceMethod{
    [MDSecViewController testfun];
    //获取方法列表
    unsigned int methodCount;
    Method *methods = class_copyMethodList([self class], &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        Method m = methods[i];
        NSLog(@"SEL：%d-----%s", i, sel_getName(method_getName(m)));
        
    }
    free(methods);
}
+(void)testfun{
    NSLog(@"类方法执行了");
    //获取类方法列表
    unsigned int methodCount;
    //获取元类
    Class obj = object_getClass([self class]);
    Method *methods = class_copyMethodList(obj, &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        Method m = methods[i];
        NSLog(@"SEL：%d-----%s", i, sel_getName(method_getName(m)));
    }
    free(methods);
}

-(void)clickAction{
    [MDViewController hookClassMethod];
}
#pragma mark - 带参数的实例方法
-(void)clickInstance{
    [self clickInstanceWithArguments:10 name:@"夏侯惇"];
}
-(void)clickInstanceWithArguments:(NSInteger )age name:(NSString *)name {
    NSLog(@"%@ is %ld 岁了",name,age);
}
#pragma mark - 带参数的类方法
-(void)clickClass {
    [MDSecViewController clickClassMethodWithArgument:@"元歌" address:@"王者峡谷对方野区第三个坑"];
}
+(void)clickClassMethodWithArgument:(NSString *)name address:(NSString *)address {
    NSLog(@"%@在%@上班",name,address);
}
@end
