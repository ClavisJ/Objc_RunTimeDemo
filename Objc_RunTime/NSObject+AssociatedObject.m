//
//  NSObject+AssociatedObject.m
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)


@dynamic associatedObject;

- (void)setAssociatedObject:(id)object {
    
    // 设置关联对象
    objc_setAssociatedObject(self, @selector(associatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject {
    
    // 得到关联对象
    return objc_getAssociatedObject(self, @selector(associatedObject));
}

@end
