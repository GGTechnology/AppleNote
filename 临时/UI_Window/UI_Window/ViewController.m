//
//  ViewController.m
//  UI_Window
//
//  Created by kadis on 2019/8/12.
//  Copyright © 2019 kadis. All rights reserved.
//

#import "ViewController.h"
#import "HomePagePopView.h"
#import "LGDAlert.h"
#import "AttendanceAlertView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *_MyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
}

- (void)jdk {
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    window.backgroundColor = [UIColor blackColor];
//    window.alpha = 0.5;
    UIButton *a = [[UIButton alloc] initWithFrame:self.view.bounds];
    a.backgroundColor = [UIColor cyanColor];
    [a addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    [window addSubview:a];
    [[[UIApplication sharedApplication] keyWindow] addSubview:a];
}
- (IBAction)Animation:(id)sender {
//    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:100 options:UIViewAnimationOptionRepeat animations:^{
//        //执行动画
//        self->__MyView.transform = CGAffineTransformScale(self->__MyView.transform, 0.5, 0.5);//缩放
//        self->__MyView.transform = CGAffineTransformRotate(self->__MyView.transform, M_PI_4);//旋转
//        self->__MyView.transform = CGAffineTransformTranslate(self->__MyView.transform, 200, 100);//平移
//
//    } completion:^(BOOL finished) {
//
//    }];
    
//    self->__MyView.transform.transform = CGAffineTransformScale(self->__MyView.transform.transform, 0.5, 0.5);//缩放
//    self->__MyView.transform.transform = CGAffineTransformRotate(self->__MyView.transform.transform, M_PI_4);//旋转
    
    [UIView animateWithDuration:3 animations:^{
        //执行动画
        self->__MyView.transform = CGAffineTransformTranslate(self->__MyView.transform, 200, 100);//平移
    }];
    [[AttendanceAlertView shareInstance] showAlertWithFailHeadTitle:nil textTitle:nil leftHandle:^(id anyID) {

    } rightHandle:^(id anyID) {
        NSLog(@"重新补签");
    }];
    
}

- (IBAction)ff:(id)sender {
//    [self jdk];
//    [HomePagePopView show:@"a" subTitle:@"b" image:[UIImage imageNamed:@"aa"] content:@"c" click:^{
//
//    } close:^{
//
//    }];
    NSLog(@"弹出视图");
//    [[LGDAlert shareInstance] showAlertWithType:AlertTypeNornal headTitle:@"a" textTitle:@"b" leftHandle:^(id anyID) {
//        NSLog(@"取消");
//    } rightHandle:^(id anyID) {
//        NSLog(@"确定");
//    }];
    
//    [[AttendanceAlertView shareInstance] showAlertWithSuccellCount:@"50"];
    
//    [[AttendanceAlertView shareInstance] showAlertWithFailHeadTitle:nil textTitle:nil leftHandle:^(id anyID) {
//
//    } rightHandle:^(id anyID) {
//        NSLog(@"重新补签");
//    }];
    
    [[AttendanceAlertView shareInstance] showAlertWithHeadTitle:@"邀好友助力 得补签机会" supplementDate:@"补签日期: 7月22日" textTitle:@"邀请3位新用户助力补签，补签成功成功后可获得奖励" supplementTime:@"12 34 59" headIcon:nil peopleNum:@"2位" leftHandle:^(id anyID) {
        
    } rightHandle:^(id anyID) {
//        NSLog(@"");
        NSLog(@"邀请好友");
    }];
}

- (void)remove:(UIWindow *)view {
//    [self.view removeFromSuperview];
    [view removeFromSuperview];
}

@end
