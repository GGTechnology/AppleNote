//
//  ViewController.m
//  present半透明
//
//  Created by mingcol on 2019/7/9.
//  Copyright © 2019 mingcol. All rights reserved.
//

#import "ViewController.h"
#import "LGDPresentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    // Do any additional setup after loading the view.
}
- (IBAction)action {
    NSLog(@"🍎");
//    LGDPresentView *vc = [[LGDPresentView alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:vc animated:NO completion:nil];
    LGDPresentView *lagerPicVC = [[LGDPresentView alloc]init];
    self.definesPresentationContext = YES;
    lagerPicVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有 ios8 later
    // 动画关闭 不然会有个半透明背景跟着动画 很丑..
    [self presentViewController:lagerPicVC animated:NO completion:^{
        // 根据 colorWithAlphaComponent:设置透明度，如果直接使用alpha属性设置，会出现Vc里面的子视图也透明.
        lagerPicVC.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }];
}



@end
