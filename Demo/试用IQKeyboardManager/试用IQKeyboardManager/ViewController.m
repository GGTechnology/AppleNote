//
//  ViewController.m
//  试用IQKeyboardManager
//
//  Created by kadis on 2019/8/14.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import <IQKeyboardManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  键盘不显示 Toolbar
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //  点击其它收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}


@end
