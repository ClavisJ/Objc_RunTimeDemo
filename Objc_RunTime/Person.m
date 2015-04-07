//
//  Per.m
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// 利用runtime机制进行属性的归档接档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i<count; i++) {
        
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@ %p name = %@>", [self class], self, _name];
}

@end
