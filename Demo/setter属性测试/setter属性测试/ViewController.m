//
//  ViewController.m
//  setter属性测试
//
//  Created by kadis on 2019/8/23.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "views.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    views *view = [views new];
    view.testArray = @[@"string", @1];
    view.testDic = @{@"name":@"mike", @"age":@17};
}


@end
