//
//  ViewController.m
//  KVO案例
//
//  Created by kadis on 2019/11/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property (strong, nonatomic) NSMutableArray *array;
@end
@implementation Person
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}
@end

@interface ViewController ()
@property (strong, nonatomic) Person *person;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加监听代码
    self.person = [Person new];
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
//    [self addObserver:self forKeyPath:@"array" options:(NSKeyValueObservingOptionNew) context:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(actions:) userInfo:@{@"time":@"10"} repeats:YES];
}

// 每秒执行的事件
- (void)actions:(NSTimer *)time {
//    NSDictionary *dic = time.userInfo;
//    NSLog(@"%@", dic);
    
    
    int value = arc4random() % 100;
    NSLog(@"定时器 = %d", value);
    self.person.name = [NSString stringWithFormat:@"%d", value];
    self.person.sex = [NSString stringWithFormat:@"%d", value / 2];
}

//获得回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"监听者 = %@", change);
//    NSLog(@"keyPath🏀 = %@", keyPath);
//    NSLog(@"object🎾 = %@", object);
//    NSLog(@"context🏐️ = %@", context);
    
//    NSLog(@"%@ - %@", keyPath, change);
}

- (void)dealloc {
    // 移除监听
    [self.person removeObserver:self forKeyPath:@"name"];
    
    // 清除定时器
    [self.timer invalidate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.person.name = @"herui";
    
        [self.person willChangeValueForKey:@"name"];
        [self.person didChangeValueForKey:@"name"];
    
    
//    //重点在这里
//    NSMutableArray *arrM = [self mutableArrayValueForKey:@"array"];
//    [arrM addObject:@1];
}


@end
