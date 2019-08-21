//
//  ViewController.m
//  跳转系统系列开关设置
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)one:(id)sender {
    UIAlertAction *alertSure = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"'唯美美妆应用' 已关闭蜂窝移动数据" message:@"您可以在通过在手机的 '设置'-->'蜂窝移动网络'中打开蜂窝支持" preferredStyle:UIAlertControllerStyleAlert];
    
    [alerVC addAction:alertCancel];
    [alerVC addAction:alertSure];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alerVC animated:YES completion:nil];
}


@end
