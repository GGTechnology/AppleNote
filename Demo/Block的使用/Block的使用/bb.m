//
//  bb.m
//  Block的使用
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "bb.h"

@interface bb ()

@end

@implementation bb

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//- (void)viewWillDisappear:(BOOL)animated {
////    self.block3(@"你好吗");
//    self.block3(@"你好");
//}

- (void)action {
//    self.block3(@"你好");
    NSLog(@"🍎 %@ 🍎", self.block);
    NSDictionary *dic = @{@"a":@1};
    if (self.block) {
        self.block(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
