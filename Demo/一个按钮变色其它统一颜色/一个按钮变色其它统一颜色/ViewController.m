//
//  ViewController.m
//  一个按钮变色其它统一颜色
//
//  Created by kadis on 2019/9/10.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *iv;

@end

@implementation ViewController

- (UIView *)iv {
    if (!_iv) {
        _iv = [[UIView alloc] initWithFrame:self.view.bounds];
        _iv.backgroundColor = [UIColor purpleColor];
    }
    return _iv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.iv];
    [self addBtn];
}

- (void)addBtn {
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50+i*70, 100, 50, 50)];
        btn.backgroundColor = [UIColor greenColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.iv addSubview:btn];
    }
}
- (void)action:(UIButton *)btn {
    for (UIButton *bb in self.iv.subviews) {
        if (bb.tag == btn.tag) {
            bb.backgroundColor = [UIColor redColor];
        } else {
            bb.backgroundColor = [UIColor greenColor];
        }
    }
}

@end
