//
//  ViewController.m
//  镂空UIView
//
//  Created by mingcol on 2019/7/8.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"
#import "LGDHollowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LGDHollowView *vc = [[LGDHollowView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:vc];
}


@end
