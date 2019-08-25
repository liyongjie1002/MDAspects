//
//  MDAOPManager.m
//  AOP_Demo
//
//  Created by 李永杰 on 2018/6/6.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "MDAOPManager.h"
#import "MDAOPManager+MDViewController.h"
#import "MDAOPManager+MDSecViewController.h"

// hook到方法回调
typedef void (^AspectEventBlock)(id<MDAspectInfo> aspectInfo);

@implementation MDAOPManager

+(void)load{ // 加载配置文件
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic addEntriesFromDictionary:[MDAOPManager AOP_MDViewControllerConfigDic]];
    [mutableDic addEntriesFromDictionary:[MDAOPManager AOP_MDSecViewControllerConfigDic]];
    [self configAOPWithDic:mutableDic];
    
}

+(void)configAOPWithDic:(NSDictionary *)configDic{
    // 解析配置文件
    for (NSString *className in configDic) {
        Class clazz = NSClassFromString(className);//拿到类名
        NSDictionary *config = configDic[className];//配置信息
        NSArray *trackArr = config[@"TrackEvents"];//方法数组
        if (trackArr) {
            for (NSDictionary *event in trackArr) {
                
                AspectEventBlock buttonBlock = event[@"block"];//回调
                NSString *method = event[@"EventSelectorName"];//方法名
                NSString *moment = event[@"moment"];//hook时机
                
                MDAspectOptions option = MDAspectPositionAfter;
                if ([moment isEqualToString:@"before"]) {
                    option = MDAspectPositionBefore;
                }else if ([moment isEqualToString:@"instead"]){
                    option = MDAspectPositionInstead;
                }
                
                SEL selector = NSSelectorFromString(method);

                if ([method hasPrefix:@"+"]) {//hook类方法
                    method = [method substringFromIndex:1];
                    selector = NSSelectorFromString(method);

                    [clazz aspect_hookClassSelector:selector withOptions:option usingBlock:^(id<MDAspectInfo> aspectInfo) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            buttonBlock(aspectInfo);
                        });
                    } error:NULL];
                }else{//hook实例方法
                    
                    [clazz aspect_hookSelector:selector withOptions:option usingBlock:^(id<MDAspectInfo> aspectInfo) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            buttonBlock(aspectInfo);
                        });
                    } error:NULL];
                }
            }
        }
    }
}
@end
