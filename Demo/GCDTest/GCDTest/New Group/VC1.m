//
//  VC1.m
//  GCDTest
//
//  Created by LvGuangDa on 2020/3/16.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "VC1.h"

@interface VC1 () {
    UIButton *btn;
}

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    btn  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)test {
    
//    [self codeDisplay:@"显示代码"];
    self.codeStr = @"显示代码";
    self.resultStr = @"显示结果";
    
//    NSLog(@"🍎currentThread---%@",[NSThread currentThread]);  // 打印当前线程
//    NSLog(@"🍏syncConcurrent---begin");
//    
//    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_sync(queue, ^{
//        // 追加任务 1
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"🍊1---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    
//    dispatch_sync(queue, ^{
//        // 追加任务 2
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"🍋2---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    
//    dispatch_sync(queue, ^{
//        // 追加任务 3
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"🍉3---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    
//    NSLog(@"🥭syncConcurrent---end");
}

- (void)queueCreat {
    // 串行队列的创建方法
    dispatch_queue_t queueSerial = dispatch_queue_create("queueSerial ", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_main();
    
//    dispatch_get_global_queue
    // 全局并发队列的获取方法
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    
    
    // 并发队列的创建方法
    dispatch_queue_t queueConcurrent = dispatch_queue_create("queueConcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    // 同步执行任务创建方法
    dispatch_sync(queueSerial, ^{
        // 这里放同步执行任务代码
        [self performSelector:@selector(clickBack) withObject:self afterDelay:1.0];
    });

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 异步执行任务创建方法
    dispatch_async(mainQueue, ^{
        // 这里放异步执行任务代码
        self->btn.backgroundColor = [UIColor orangeColor];
    });
}

- (void)clickBack {
    btn.backgroundColor = [UIColor yellowColor];
}

@end
