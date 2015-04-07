//
//  Per.h
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) BOOL gender;
@property (nonatomic, copy) NSString *hobby;

@end
