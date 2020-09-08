//
//  XDArrayTool.m
//  SwiftLearning
//
//  Created by caixiaodong on 2020/5/9.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

/*
Question

 2. Let’s say we have a mutable array with 5 strings, and we’ll have to delete them one by one, please give an executable sample with your code.
 (PS: Please do not use ArrayList directly!)
*/

#import "XDArrayTool.h"

@implementation XDArrayTool

+ (void)test {
    NSMutableArray *array = @[@"1",@"2",@"3",@"4",@"5"].mutableCopy;
    
    [self deleteAllObjectInArray:array];
}

+ (void)deleteAllObjectInArray:(NSMutableArray *)array {
    
    @synchronized (array) {
        NSLog(@"first array(%@)",array);
        
        for (NSInteger i = 0; i < array.count; ) {
            NSString *string = [array objectAtIndex:i];
            NSLog(@"we are going to remove string(%@)",string);
            [array removeObjectAtIndex:i];
        }
        
//        for (NSInteger i = (array.count - 1); i >= 0; i--) {
//            NSString *string = [array objectAtIndex:i];
//            NSLog(@"we are going to remove string(%@)",string);
//            [array removeObjectAtIndex:i];
//        }
        
        NSLog(@"final array(%@)",array);
    }
    
    
}

@end
