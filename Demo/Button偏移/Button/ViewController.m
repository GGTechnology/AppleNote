//
//  ViewController.m
//  Button
//
//  Created by kadis on 2020/6/11.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    float x = 6;
    for (int y = 0; y < 1000; y++) {
        x = x + x*0.1;
        if (x > 60) {
            NSLog(@"%d", y);
            break;
        }
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor orangeColor];
    //设置button正常状态下的图片
    [button setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
    //设置button高亮状态下的图片
//    [button setImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateHighlighted];
//    //设置button正常状态下的背景图
//    [button setBackgroundImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
//    //设置button高亮状态下的背景图
//    [button setBackgroundImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateHighlighted];
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    [button setTitle:@"南瓜瓜" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 00, 0, 0);
//    //设置button正常状态下的标题颜色
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    //设置button高亮状态下的标题颜色
//    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:button];
}


@end
