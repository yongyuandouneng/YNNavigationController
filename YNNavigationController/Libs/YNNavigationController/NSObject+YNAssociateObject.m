//
//  NSObject+YNAssociateObject.m
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "NSObject+YNAssociateObject.h"
#import <objc/runtime.h>


@implementation NSObject (YNAssociateObject)

static char associativeObjectsKey;

- (id)yn_AssociativeObjectForKey:(NSString *)key
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associativeObjectsKey);
    
    return [dict objectForKey:key];
}

- (void)yn_RemoveAssociatedObjectForKey:(NSString *)key
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associativeObjectsKey);
    
    [dict removeObjectForKey:key];
}

- (void)yn_SetAssociativeObject:(id)object forKey:(NSString *)key
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associativeObjectsKey);
    
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &associativeObjectsKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    
    if (object == nil) {
        [dict removeObjectForKey:key];
    } else {
        [dict setObject:object forKey:key];
    }
}



@end
