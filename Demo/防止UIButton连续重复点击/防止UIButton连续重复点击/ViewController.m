//
//  ViewController.m
//  防止UIButton连续重复点击
//
//  Created by LvGuangDa on 2020/2/6.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+LGDUIButtonExtension.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [btn setTitle:@"扩展Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.intervalClickTime = 2.0;
    [btn addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
// 方法一： 可通过设置UIButton的enabled属性来防止连续重复点击。此方法不好之处就是单个按钮设置和需要设置该属性的代码比较分散，若需要修改也许涉及的代码部分比较多且分散。
- (IBAction)one:(UIButton *)sender {
    // 点击按钮后设置按钮不可点击
    sender.enabled = NO;
    
    NSLog(@"每两秒执行一次：🍎");
    // 模拟执行完任务后，或者延迟一定时间后使按钮可点击
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

// 方法二：
//    通过两个方法来设置延迟响应时间：
//
//    +cancelPreviousPerformRequestsWithTarget:selector:object:通过NSObject的该方法可取消前一次点击触发的事件
//
//-performSelector:withObject:afterDelay:该方法控制按钮的响应事件的执行时间间隔。
//
//    此方法会在连续点击按钮时取消之前的点击事件，从而只执行最后一次点击事件，不好之处就是会出现延迟现象，若一直在延迟时间内点击按钮，则会一直延迟不响应事件，直到在延迟时间内未点击该按钮才会响应按钮事件。
- (IBAction)two:(id)sender {
    [[self class] cancelPreviousPerformRequestsWithTarget:self
                                                     selector:@selector(handel:)
                                                       object:sender];
    [self performSelector:@selector(handel:) withObject:sender afterDelay:2.0];
}
- (void)handel:(id)sender {
    NSLog(@"连续点击事件的间隔2秒内的情况，最后的一次执行：🍏");
}
// 方法三：（推荐使用，可大量按钮设置）
//    通过Runtime控制UIButton响应事件的时间间隔。思路如下：
//
//    1、创建一个UIButton的类别（Category），使用runtime为UIButton增加public属性-按钮点击间隔时间intervalClickTime和private属性-是否可响应点击事件canClickButton。
//
//    2、在+load方法中使用runtime将UIButton的-sendAction:to:forEvent:方法与自定义的-mq_sendAction:to:forEvent:方法交换Implementation。
//
//    3、使用间隔时间intervalClickTime作为控制是否可响应点击事件canClickButton的计时因子，用canClickButton来控制UIButton的event事件是否有效。
- (void)btn3Action:(UIButton *)btn {
    NSLog(@"每两秒执行一次：🍌");
}


@end
