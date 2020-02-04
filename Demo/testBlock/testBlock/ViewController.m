//
//  ViewController.m
//  testBlock
//
//  Created by LvGuangDa on 2020/1/27.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "ButtonBlock.h"
#import "NSObjectBlock.h"
#import "NoTypedefViewBlock.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        
//######################################################################/
    
    ButtonBlock *ButtonBlockView = [[ButtonBlock alloc] initWithFrame:CGRectMake(kWidth/2-100, 100, 200, 345)];
    [self.view addSubview:ButtonBlockView];
    
    // -
    // - 1.
    // -
    [ButtonBlockView setFirstBlock:^{
        NSLog(@"\n「ViewController.m」🍎");
    }];
    
    // -
    // - 2.
    // -
    [ButtonBlockView setSecondBlock:^(id anyID) {
        NSLog(@"\n「ViewController.m」🍏 = %@", anyID);
    }];
    
    // -
    // - 3.
    // -
    [ButtonBlockView setThirdBlock:^NSString *(NSString *valueStr) {
        NSLog(@"\nvalueStr = %@", valueStr);
        return @"「ViewController.m」🍊";
    }];

    
//######################################################################/
   
    [[NSObjectBlock shareInstance] timeCountParamater:10 HandleBlock:^(id anyID) {
        NSLog(@"\n%@", anyID);
    }];
    

//######################################################################/
    
    NoTypedefViewBlock *labelView = [[NoTypedefViewBlock alloc] initWithFrame:CGRectMake(30, 500, kWidth-60, 100)];
    [self.view addSubview:labelView];
    [labelView TimeCount:^{
        NSLog(@"「ViewController.m」🥥");
    }];
}

@end
