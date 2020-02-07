//
//  ViewController.m
//  Runtime的测试
//
//  Created by LvGuangDa on 2020/2/7.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "MethodLazy.h"
#import <objc/message.h>

@interface ViewController () {
    MethodLazy *methodLazy;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 试试这个
    NSURL *url = [NSURL URLWithString:@"www.中文.com"];
//    NSURL *url = [NSURL URLWithString:@"www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"%@", url);
    
    
    
    
    
    methodLazy = [[MethodLazy alloc] init];
    [methodLazy performSelector:@selector(noMethodTest)];
}

@end
