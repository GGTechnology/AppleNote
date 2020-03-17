//
//  VC1.m
//  GCDTest
//
//  Created by LvGuangDa on 2020/3/16.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "VC1.h"

@interface VC1 ()<UITableViewDataSource, UITableViewDelegate> {
    UIButton *btn;
    NSArray  *GCD_dataArray;
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    [self.view addSubview:tableView];
    
    GCD_dataArray = @[@"同步执行 + 并发队列",
                      @"异步执行 + 并发队列",
                      @"同步执行 + 串行队列",
                      @"异步执行 + 串行队列",
                      @"同步执行 + 主队列",
                      @"在主线程中调用 『同步执行 + 主队列』",
                      @"在其他线程中调用『同步执行 + 主队列』",
                      @"异步执行 + 主队列"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return GCD_dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    if (indexPath.row < GCD_dataArray.count-1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", GCD_dataArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)one {
    self.codeStr = @"";
}

@end
