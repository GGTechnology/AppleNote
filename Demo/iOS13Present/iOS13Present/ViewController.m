//
//  ViewController.m
//  iOS13Present
//
//  Created by kadis on 2019/11/26.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "VC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(jj) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)jj {
    VC *a = [VC new];
    
    [self presentViewController:a animated:YES completion:nil];
}


@end
