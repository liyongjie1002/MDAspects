//
//  MDAOPManager+MDSecViewController.m
//  MDAspects_Example
//
//  Created by 李永杰 on 2018/11/9.
//  Copyright © 2018年 iyongjie@yeah.net. All rights reserved.
//

#import "MDAOPManager+MDSecViewController.h"

@implementation MDAOPManager (AOP_MDSecViewControllerConfigDic)
+(NSDictionary *)AOP_MDSecViewControllerConfigDic{
    NSDictionary *configDic = @{
                                @"MDSecViewController":@{
                                        @"TrackEvents":@[
                                                @{//实例方法
                                                    @"moment":@"after",
                                                    @"EventSelectorName":@"instanceMethod",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"实例方法");
                                                    },
                                                },
                                                @{//类方法
                                                    @"moment":@"after",
                                                    @"EventSelectorName":@"+testfun",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"类方法");
                                                    },
                                                },
                                                @{//实例方法
                                                    @"moment":@"after",
                                                    @"EventSelectorName":@"clickInstanceWithArguments:name:",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"%@",aspectInfo.arguments);
                                                    },
                                                },
                                                @{//类方法
                                                    @"moment":@"after",
                                                    @"EventSelectorName":@"+clickClassMethodWithArgument:address:",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"%@",aspectInfo.arguments);
                                                    },
                                                },
                                            ]
                                        },
                                };
    return configDic;
}
@end
