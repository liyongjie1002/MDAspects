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


typedef void (^AspectEventBlock)(id<JKUBSAspectInfo> aspectInfo);

@implementation MDAOPManager

+(void)load{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic addEntriesFromDictionary:[MDAOPManager AOP_MDViewControllerConfigDic]];
    [mutableDic addEntriesFromDictionary:[MDAOPManager AOP_MDSecViewControllerConfigDic]];
    [self configAOPWithDic:mutableDic];
    
}
+(void)configAOPWithDic:(NSDictionary *)configDic{
    
    for (NSString *className in configDic) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configDic[className];
        NSArray *trackArr = config[@"TrackEvents"];
        if (trackArr) {
            for (NSDictionary *event in trackArr) {
                
                AspectEventBlock buttonBlock = event[@"block"];
                NSString *method = event[@"EventSelectorName"];
                SEL selector = NSSelectorFromString(method);

                if ([method hasPrefix:@"+"]) {//hook类方法
                    method = [method substringFromIndex:1];
                    selector = NSSelectorFromString(method);

                    [clazz aspect_hookClassSelector:selector withOptions:JKUBSAspectPositionAfter usingBlock:^(id<JKUBSAspectInfo> aspectInfo) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            buttonBlock(aspectInfo);
                        });
                    } error:NULL];
                }else{//hook实例方法
                    
                    [clazz aspect_hookSelector:selector withOptions:JKUBSAspectPositionAfter usingBlock:^(id<JKUBSAspectInfo> aspectInfo) {
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
