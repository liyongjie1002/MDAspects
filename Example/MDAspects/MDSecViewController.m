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
@end
