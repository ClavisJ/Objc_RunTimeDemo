//
//  ViewController.m
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+AssociatedObject.h"
#import "UIAlertView+Block.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            
#pragma mark - 动态创建对象
    
    
    // 1.动态创建对象 创建一个Person类 继承自NSObject类
    Class newClass = objc_allocateClassPair([NSObject class], "Student", 0);
    
    // 使用block作为方法的IMP
    IMP myIMP = imp_implementationWithBlock(^(id _self, NSString *string) {
        NSLog(@"Hello %@", _self);
    });
    
    // 为该类增加名为Report的方法
    class_addMethod(newClass, @selector(report), (IMP)myIMP, @"v@:");
    
    // 注册该类
    objc_registerClassPair(newClass);
    
    // 创建一个 Student 类的实例
    id instantOfNewClass = [[newClass alloc] init];
    
    // 调用方法
    [instantOfNewClass report];
    
    NSObject *object =  objc_msgSend(objc_msgSend([NSObject class],@selector(alloc)),@selector(init));
    NSLog(@"%@", object);
    
            
#pragma mark - 关联对象
    
//    NSObject *object = [[NSObject alloc] init];
//    object.associatedObject = @"associated";
//    NSLog(@"%@", object.associatedObject);
    
    
#pragma mark - 给UIAlertView关联一个block对象
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"hello" message:@"hello world" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        NSLog(@"button index=%ld",buttonIndex);
    }];
    
#pragma mark - 利用RunTime进行模型归档
    
    Person *person = [[Person alloc] init];
    person.name = @"kkk";
    
    // 归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
    Person *newPerson = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@", newPerson);
    
 
    objc_msgSend(objc_msgSend([NSObject class],@selector(alloc)),@selector(init));
}


@end
