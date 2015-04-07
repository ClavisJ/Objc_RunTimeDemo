//
//  UIAlertView+Block.m
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static char key;

@implementation UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block
{
    if (block) {
        //移除所有关联
        //objc_removeAssociatedObjects(self);
        /**
         1 创建关联（源对象，关键字，关联的对象和一个关联策略。)
         2 关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
         3 关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。
         */
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        ////设置delegate
        self.delegate = self;
    }
    ////show
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ///获取关联的对象，通过关键字。
    CompleteBlock block = objc_getAssociatedObject(self, &key);
    if (block) {
        ///block传值
        block(buttonIndex);
    }
}


@end
