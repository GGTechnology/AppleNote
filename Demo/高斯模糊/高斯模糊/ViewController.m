//
//  ViewController.m
//  高斯模糊
//
//  Created by kadis on 2020/7/22.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"
#import "A_Button.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"timeforlove"];
    [self.view addSubview:imageView];

    self.boxView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 83.0, self.view.bounds.size.width, 83.0)];
    [self.view addSubview:self.boxView];

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurView.frame = self.boxView.bounds;
    [self.boxView addSubview:self.blurView];

//    CGFloat width = self.boxView.bounds.size.width / 4;
//    for (int i = 0; i < 4; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(width * i, 0, width, self.boxView.bounds.size.height);
//        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//        [button setTitle:[NSString stringWithFormat:@"Btn%d", i] forState:UIControlStateNormal];
//        [self.boxView addSubview:button];
//    }
//
//    A_Button *b = [[A_Button alloc] init];
//    b.spacing = 50;
//    b.direction = 1;
//    b.frame = CGRectMake(100, 100, 200, 100);
//    b.backgroundColor = [UIColor blackColor];
//    [b setTitle:@"标题" forState:UIControlStateNormal];
//    [b setImage:[UIImage imageNamed:@"aa"] forState:UIControlStateNormal];
//    [self.view addSubview:b];
}


@end
