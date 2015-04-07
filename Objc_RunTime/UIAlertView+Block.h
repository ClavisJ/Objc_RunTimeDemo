//
//  UIAlertView+Block.h
//  Objc_RunTime
//
//  Created by 敬洁 on 15/4/2.
//  Copyright (c) 2015年 jingj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block;

@end
