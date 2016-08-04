//
//  NSObject+YNAssociateObject.h
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YNAssociateObject)

- (id)yn_AssociativeObjectForKey:(NSString *)key;

- (void)yn_RemoveAssociatedObjectForKey:(NSString *)key;

- (void)yn_SetAssociativeObject:(id)object forKey:(NSString *)key;

@end
