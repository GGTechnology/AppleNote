//
//  LGDPresentView.m
//  present半透明
//
//  Created by mingcol on 2019/7/9.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "LGDPresentView.h"

@interface LGDPresentView ()

@end

@implementation LGDPresentView

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    UIButton *view = [[UIButton alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.5;
    [view addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
