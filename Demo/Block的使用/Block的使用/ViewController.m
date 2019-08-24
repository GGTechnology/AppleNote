//
//  ViewController.m
//  Block的使用
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "bb.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)push {
    bb *vc = [bb new];
    [vc setBlock:^(NSDictionary * _Nonnull str) {
        NSLog(@"%@", str);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
