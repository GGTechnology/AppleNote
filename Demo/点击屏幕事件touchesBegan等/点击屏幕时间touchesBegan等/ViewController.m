//
//  ViewController.m
//  点击屏幕时间touchesBegan等
//
//  Created by LvGuangDa on 2020/2/6.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 手指按下屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"手指按下屏幕");
    //获取触摸点的集合
   NSSet * allTouches = [event allTouches];
   //获取触摸对象
   UITouch * touch = [allTouches anyObject];
   //返回触摸点所在视图中的坐标
   CGPoint point = [touch locationInView:[touch view]];
   NSLog(@"point的位置--x:%f y:%f",point.x,point.y);
}
// 手指在屏幕移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"手指在屏幕移动");
}
// 手指离开屏幕
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"手指离开屏幕");
}
// 意外中断事件（如打电话打扰）
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"意外中断事件（如打电话打扰）");
}

// 加速计事件（一般用于可以产生加速计事件的设备，如微信的摇一摇功能）
- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    NSLog(@"微信开始摇一摇");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    NSLog(@"微信开始摇一摇结束");
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    NSLog(@"微信开始摇一摇加速中断");
}


@end
