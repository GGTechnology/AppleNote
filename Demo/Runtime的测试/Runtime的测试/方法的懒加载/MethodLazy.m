//
//  MethodLazy.m
//  Runtime的测试
//
//  Created by LvGuangDa on 2020/2/7.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "MethodLazy.h"
#import <objc/runtime.h>

@implementation MethodLazy

// 当这个类被调用一个没有实现的方法就到这里来了
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // 在这里执行方法
    /*
     * parameter
     *
     * cls: 类类型
     * name: 方法编号
     * imp: 方法实现，就是一个函数指针，根据方法编号查找
     * types: 返回值类型，C语言的"v"，最好写 nil
     */
    class_addMethod([MethodLazy class], sel, (IMP)print, nil);
    
    return [super resolveInstanceMethod:sel];
}

void print() {
    NSLog(@"🍎未找到这个方法");
}

@end
