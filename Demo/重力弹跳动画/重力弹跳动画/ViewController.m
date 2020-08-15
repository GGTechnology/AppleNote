//
//  ViewController.m
//  重力弹跳动画
//
//  Created by kadis on 2020/8/6.
//  Copyright © 2020 lvguangda. All rights reserved.
//

#import "ViewController.h"

#define dutime 0.2f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [view addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)click:(UIButton *)btn {
    [self animationShootOut:btn];
//    [self one:btn];
//    [self shakerAnimation:btn Duration:2 Height:50];
}

//usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
//
//initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果，弹跳结束后中心点下移10。
- (void)one:(UIView *)view {
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGPoint tempPoint = view.center;
        tempPoint.y += 50;
        view.center = tempPoint;
    } completion:^(BOOL finished) {
        
    }];
}

//弹跳结束后中心点不变，推荐使用此方法。
- (void)shakerAnimation:(UIView *)view Duration:(NSTimeInterval)duration Height:(float)height {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currenTx = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currenTx), @(currenTx + height), @(currenTx-height/3*2), @(currenTx + height/3*2), @(currenTx - height/3), @(currenTx + height/3), @(currenTx)];
    animation.keyTimes = @[@(0), @(0.0225), @(0.425), @(0.6), @(0.75), @(0.875), @(1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

//  动画弹跳效果关键代码
//  弹跳多次可自行多嵌套几次   调用此方法  只需传入弹跳对象
- (void)animationShootOut:(UIView *)animationView {
    CGRect frame = animationView.frame;
    [UIView animateWithDuration:dutime delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:dutime delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            //弹起
            animationView.frame = CGRectMake(frame.origin.x, frame.origin.y-20, frame.size.width, frame.size.height);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:dutime delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void){
                //下降
                animationView.frame = frame;
            } completion:^(BOOL finished){
                [UIView animateWithDuration:dutime delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                    //弹起
                    animationView.frame = CGRectMake(frame.origin.x, frame.origin.y-10, frame.size.width, frame.size.height);
                } completion:^(BOOL finished){
                    //下降
                    [UIView animateWithDuration:dutime delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                        animationView.frame = frame;
                    } completion:^(BOOL finished){
                    }];
                }];
            }];
        }];
    }];
}


@end
