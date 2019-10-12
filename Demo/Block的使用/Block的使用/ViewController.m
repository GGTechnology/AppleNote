//
//  ViewController.m
//  Block的使用
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "aa.h"

@interface ViewController ()
@property (nonatomic, strong) aa *cc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cc = [[aa alloc] initWithFrame:CGRectMake(10, 100, 250, 250)];
    _cc.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_cc];
    [_cc setBlock_a1:^(NSString *str, NSDictionary *dic) {
        NSLog(@"%@ %@", str, dic);
    }];
    [_cc setBlock_a2:^(NSString *str, NSDictionary *dic) {
        NSLog(@"%@ %@", str, dic);
    }];
}

@end
