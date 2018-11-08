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
                                                    @"EventSelectorName":@"instanceMethod",
                                                    @"block":^(id<JKUBSAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"让你点");
                                                    },
                                                },
                                                @{//类方法
                                                    @"EventSelectorName":@"+testfun",
                                                    @"block":^(id<JKUBSAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"就点");
                                                    },
                                                },
                                            ]
                                        },
                                };
    return configDic;
}
@end
