//
//  ViewController.m
//  AlertView
//
//  Created by kadis on 2019/8/14.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "LGDAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)one {
    [[LGDAlertView shareInstance] showAlertWithText:@"one"];
}

- (IBAction)two {
    [[LGDAlertView shareInstance] showAlertWithBlock:@"two" leftHandle:^(id  _Nonnull anyID) {
        NSLog(@"取消");
    } rightHandle:^(id  _Nonnull anyID) {
        NSLog(@"%@", anyID);
    }];
}

@end
