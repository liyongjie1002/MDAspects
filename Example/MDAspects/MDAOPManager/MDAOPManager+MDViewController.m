//
//  MDAOPManager+MDViewController.m
//  MDAspects_Example
//
//  Created by 李永杰 on 2018/11/1.
//  Copyright © 2018年 iyongjie@yeah.net. All rights reserved.
//

#import "MDAOPManager+MDViewController.h"

@implementation MDAOPManager (MDViewController)
+(NSDictionary *)AOP_MDViewControllerConfigDic{
    NSDictionary *configDic = @{
                                @"MDViewController":@{
                                        @"TrackEvents":@[
                                                @{//实例方法
                                                    @"EventSelectorName":@"instanceMethod",
                                                    @"block":^(id<JKUBSAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"跳转了");
                                                    },
                                                },
                                                @{//类方法
                                                    @"EventSelectorName":@"+hookClassMethod",
                                                    @"block":^(id<JKUBSAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"hook到了MDViewController的类方法");
                                                    },
                                                },
                                            ]
                                        },
                                };
    return configDic;
}
@end
