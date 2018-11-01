//
//  MDAOPManager.m
//  AOP_Demo
//
//  Created by 李永杰 on 2018/6/6.
//  Copyright © 2018年 muheda. All rights reserved.
//

#import "MDAOPManager.h"
#import "MDAOPManager+MDViewController.h"

typedef void (^AspectEventBlock)(id<JKUBSAspectInfo> aspectInfo);

@implementation MDAOPManager

+(void)load{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic addEntriesFromDictionary:[MDAOPManager AOP_MDViewControllerConfigDic]];
    [self configAOPWithDic:mutableDic];
    
}
+(void)configAOPWithDic:(NSDictionary *)configDic{
    
    for (NSString *className in configDic) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configDic[className];
        NSArray *trackArr = config[@"TrackEvents"];
        if (trackArr) {
            for (NSDictionary *event in trackArr) {
                
                SEL selecor;
                AspectEventBlock buttonBlock = event[@"block"];
                BOOL isClassMethod = [event[@"isClassMethod"] boolValue];
                NSString *method = event[@"EventSelectorName"];
                selecor = NSSelectorFromString(method);
                [self trackTouchEventWithClass:clazz selector:selecor block:buttonBlock isClassMethod:isClassMethod];
            }
        }
    }
}

+ (void)trackTouchEventWithClass:(Class)class selector:(SEL)selector block:(AspectEventBlock)block isClassMethod:(BOOL)isClassMethod{
    if (isClassMethod) {
        [class aspect_hookClassSelector:selector withOptions:JKUBSAspectPositionAfter usingBlock:^(id<JKUBSAspectInfo> aspectInfo) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(aspectInfo);
            });
        } error:NULL];
    }else{
        [class aspect_hookSelector:selector withOptions:JKUBSAspectPositionAfter usingBlock:^(id<JKUBSAspectInfo> aspectInfo) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(aspectInfo);
            });
        } error:NULL];
    }
} 


@end
