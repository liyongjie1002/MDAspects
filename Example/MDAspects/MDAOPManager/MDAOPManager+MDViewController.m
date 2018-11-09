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
                                                    @"moment":@"before",
                                                    @"EventSelectorName":@"instanceMethod",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"跳转");
                                                    },
                                                },
                                                @{//类方法
                                                    @"moment":@"instead",
                                                    @"EventSelectorName":@"+hookClassMethod",
                                                    @"block":^(id<MDAspectInfo>aspectInfo){
                                                        // 获取方法的参数
                                                        NSLog(@"到处可以hook到我");
                                                    },
                                                },
                                            ]
                                        },
                                };
    return configDic;
}
@end
