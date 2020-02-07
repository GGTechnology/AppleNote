//
//  NSURL+LGDNSURL.m
//  Runtime的测试
//
//  Created by LvGuangDa on 2020/2/7.
//  Copyright © 2020 shijunnian. All rights reserved.
//

/*
 
runtime
 
    在程序运行的时候，动态的修改一个类的实现
思路：利用 runtime 修改系统 URLWithString 方法的实现
 1.runtime 可以交换方法的实现
 {
     // 两个方法互相交换的实现
     // method_exchangeImplementations(Method  _Nonnull m1, Method  _Nonnull m2)
     
     // 获取类方法
     // class_getInstanceMethod(Class  _Nullable __unsafe_unretained cls, SEL  _Nonnull name)
     
     // 获取实例方法
     // class_getClassMethod(Class  _Nullable __unsafe_unretained cls, SEL  _Nonnull name)
 }
 
 */

#import "NSURL+LGDNSURL.h"
#import <objc/runtime.h>

@implementation NSURL (LGDNSURL)

+ (void)load {
    // 前提是在 TARGETS -> Build Phases -> Compile Sources 有添加「本文件NSURL NSURL+LGDNSURL.m」
    NSLog(@"进入程序比 main 函数更加早");
    
    // 所以可以在这里进行交换方法的实现
    // 获取到系统的方法
    Method systemURLWithString = class_getClassMethod([NSURL class], @selector(URLWithString:));
    // 获取到自己写的方法
    Method lgdURLWithString = class_getClassMethod([NSURL class], @selector(LGDNSURL:));
    // 交换两个方法
    method_exchangeImplementations(systemURLWithString, lgdURLWithString);
    
}



// 自定义的方法
+ (instancetype)LGDNSURL:(NSString *)str
{
    // 自己调取自己方法，防止递归
    NSURL *url = [self LGDNSURL:str];
    if (!url) {
        NSLog(@"url🈳️了");
        url = [self LGDNSURL:@"https://www.baidu.com/"];
    }
    
    return url;
}

@end
