//
//  ViewController.m
//  SEL使用方法
//
//  Created by kadis on 2019/8/19.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface ViewController ()

@end

@interface Person : NSObject
- (void)test;
- (void)test:(NSString *)string;
@end

@implementation Person
- (void)test {
    NSLog(@"___test___");
}
- (void)test:(NSString *)string {
    NSLog(@"___test___%@", string);
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *p = [Person new];
    
    // 手动把 test 方法包装成 SEL 类型
    SEL s1 = @selector(test);
    SEL s2 = @selector(test:);
    
    // 响应方法
    SuppressPerformSelectorLeakWarning([p performSelector:s1]);
    SuppressPerformSelectorLeakWarning([p performSelector:s2 withObject:@"参数"]);
    
    
    SEL selector1 = NSSelectorFromString(@"test");
    ((void (*)(id, SEL))[p methodForSelector:selector1])(p, selector1);
}

@end
