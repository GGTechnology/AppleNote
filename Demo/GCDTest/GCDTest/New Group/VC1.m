//
//  VC1.m
//  GCDTest
//
//  Created by LvGuangDa on 2020/3/16.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "VC1.h"

@interface VC1 ()<UITableViewDataSource, UITableViewDelegate> {
    UIButton  *btn;
    NSArray   *GCD_dataArray;
    NSArray   *GCD_imageArray;
}

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                      @"异步执行 + 主队列",
                      @"",
                      @"同步执行 + 主队列",
                      @"在主线程中调用 『同步执行 + 主队列』",
                      @"在其他线程中调用『同步执行 + 主队列』",
                      @"异步执行 + 主队列"];
   
    GCD_imageArray = @[@"GCD_SyncConcurrent",
                       @"GCD_AsyncConcurrent",
                       @"GCD_SyncSerial",
                       @"GCD_AsyncSerial",
                       @"GCD_SyncMain",
                       @"GCD_AsyncMain"];
}
- (void)viewDidDisappear:(BOOL)animated {
    [self close];
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
    
    if (indexPath.row <= GCD_imageArray.count) {
        self.codeImageStr = [NSString stringWithFormat:@"%@", GCD_imageArray[indexPath.row]];
    }
    
    switch (indexPath.row) {
        case 0:
            [self syncConcurrent];
            break;
        case 1:
            [self asyncConcurrent];
            break;
        case 2:
            [self syncSerial];
            break;
        case 3:
            [self asyncSerial];
            break;
        case 4:
        {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"此运行会卡死" message:@"是否执行?" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self syncMain];
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
            break;
        case 5:
            [self asyncMain];
            break;
        default:
            break;
    }
}

/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncConcurrent {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n", [NSThread currentThread]];
    
    NSLog(@"syncConcurrent---begin\n");
    string = [string stringByAppendingString:@"syncConcurrent---begin\n"];
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    NSLog(@"syncConcurrent---end");
    string = [string stringByAppendingString:@"syncConcurrent---end\n"];
    self.resultStr = string;
}

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)asyncConcurrent {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n", [NSThread currentThread]];
    
    NSLog(@"asyncConcurrent---begin");
    string = [string stringByAppendingString:@"asyncConcurrent---begin\n"];
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
       
    dispatch_async(queue, ^{
       // 追加任务 1
       [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
       NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
       string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
       self.resultStr = string;
    });

    dispatch_async(queue, ^{
       // 追加任务 2
       [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
       NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
       string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
       self.resultStr = string;
    });

    dispatch_async(queue, ^{
       // 追加任务 3
       [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
       NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
       string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
       self.resultStr = string;
    });
    
    NSLog(@"asyncConcurrent---end");
    string = [string stringByAppendingString:@"asyncConcurrent---end\n"];
    self.resultStr = string;
}

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)syncSerial {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n",[NSThread currentThread]];
    
    NSLog(@"syncSerial---begin");
    string = [string stringByAppendingString:@"syncSerial---begin\n"];
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    NSLog(@"syncSerial---end");
    string = [string stringByAppendingString:@"syncSerial---end\n"];
    self.resultStr = string;
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)asyncSerial {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n",[NSThread currentThread]];
    
    NSLog(@"asyncSerial---begin");
    string = [string stringByAppendingString:@"asyncSerial---begin\n"];
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    NSLog(@"asyncSerial---end");
    string = [string stringByAppendingString:@"asyncSerial---end\n"];
    self.resultStr = string;
}

/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncMain {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n",[NSThread currentThread]];
    
    NSLog(@"syncMain---begin");
    string = [string stringByAppendingString:@"syncMain---begin\n"];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    NSLog(@"syncMain---end");
    string = [string stringByAppendingString:@"syncMain---end\n"];
    self.resultStr = string;
}

/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (void)asyncMain {
    __block NSString *string;
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    string = [NSString stringWithFormat:@"currentThread---%@\n",[NSThread currentThread]];
    
    NSLog(@"asyncMain---begin");
    string = [string stringByAppendingString:@"asyncMain---begin\n"];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"1---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"2---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        string = [string stringByAppendingFormat:@"3---%@\n",[NSThread currentThread]];
        self.resultStr = string;
    });
    
    NSLog(@"asyncMain---end");
    string = [string stringByAppendingString:@"asyncMain---end\n"];
    self.resultStr = string;
}

@end
