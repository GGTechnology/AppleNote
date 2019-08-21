//
//  ViewController.m
//  init和initwithframe的区别
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "view.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    view *v = [[view alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    
    v = [[view alloc] init];
    
    
    
    [self.view addSubview:v];
    
    
}


@end
