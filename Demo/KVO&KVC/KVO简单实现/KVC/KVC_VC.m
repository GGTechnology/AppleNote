//
//  KVC_VC.m
//  KVO简单实现
//
//  Created by LvGuangDa on 2020/2/6.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "KVC_VC.h"

// 书籍类
@interface Book : NSObject
@property(nonatomic, strong) NSString *name;
@end
@implementation Book
@end

// 学生类
@interface Student : NSObject
@property(nonatomic) int age;
@property(nonatomic, strong) Book *book;
@end
@implementation Student
@end

// 减少代码量（遍历「字母类」里的成员变量的值）
@interface Letter : NSObject
@property(nonatomic, strong) NSString *a;
@property(nonatomic, strong) NSString *b;
@property(nonatomic, strong) NSString *c;
@property(nonatomic, strong) NSString *d;
@end
@implementation Letter
@end

@interface KVC_VC ()

@end

@implementation KVC_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setValue:@"testValue" forKey:@"testKey"];
    NSString *b = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"testKey"]];
    NSLog(@"🌞 = %@", b);
    
    Book *book = [[Book alloc] init];
    NSLog(@"🍏 = %@", book.name);   // 🍏 = (null)
    [book setValue:@"Objective-C" forKey:@"name"];
    NSLog(@"🍎 = %@", book.name);   // 🍎 = Objective-C
    
    Student *stu = [[Student alloc] init];
    NSLog(@"🏀 = %d", stu.age);    // 🏀 = 0
    [stu setValue:[NSNumber numberWithInt:18] forKey:@"age"];
    NSLog(@"🏐️ = %d", stu.age);    // 🏐️ = 18
    
    NSLog(@"😊 = %@", stu.book);   // 😊 = (null)
    [stu setValue:book forKey:@"book"];
    NSLog(@"😭 = %@", stu.book);   // 😭 = <Book: 0x2826b1460>
    
    NSLog(@"📚 = %@", [stu valueForKeyPath:@"book.name"]);
    // 📚 = Objective-C
    
    NSLog(@"------------------------------------------\n");
    [self testLetter];
    
    NSLog(@"------------------------------------------\n");
    [self testValue];
}

// 获取值简化
- (void)testLetter {
    Letter *let = [[Letter alloc] init];
    let.a = @"🔴";
    let.b = @"🟡";
    let.c = @"🟢";
    let.d = @"🟣";
    
    NSArray *array = @[@"a", @"b", @"c", @"d"];
    
    // ------------------------------------
    for(NSString *str in array) {
        if ([str isEqualToString:@"a"]) {
            NSLog(@"%@ = %@", str, let.a);
        }
        else if ([str isEqualToString:@"b"]) {
            NSLog(@"%@ = %@", str, let.b);
        }
        else if ([str isEqualToString:@"c"]) {
            NSLog(@"%@ = %@", str, let.c);
        }
        else if ([str isEqualToString:@"d"]) {
            NSLog(@"%@ = %@", str, let.d);
        }
    }
    // ---- ！！以上代码可简化为以下 ！！ ------
    
    // 使用 KVC 简化代码
    for(NSString *str in array) {
        // 只要 let 里有 str 对应的值，就会得到
        // 但是慎用，let 里无 str，则会异常CRESH
        NSLog(@"KVC简化：%@ = %@", str, [let valueForKey:str]);
    }
}

// 重新赋值简化
- (void)testValue {
     Letter *let = [[Letter alloc] init];

    // 本来是要这样写的
    let.a = @"🟥";
    let.b = @"🟨";
    let.c = @"🟩";
    let.d = @"🟪";
    NSArray *array = @[@"a", @"b", @"c", @"d"];
    for(NSString *str in array) {
        NSLog(@"%@ = %@", str, [let valueForKey:str]);
    }
    
    // KVC 简化赋值
    NSDictionary *dic = @{@"a":@"❤️",
                          @"b":@"💛",
                          @"c":@"💚",
                          @"d":@"💜"};
    [let setValuesForKeysWithDictionary:dic];
    for(NSString *str in array) {
        NSLog(@"KVC简化赋值：%@ = %@", str, [let valueForKey:str]);
    }
}

@end

/*
常用方法

// 设置键值
- (void)setValue:(id)value forKey:(NSString *)key;

// 通过键获取值
- (id)valueForKey:(NSString *)key;

// 设置键值路径
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath;

// 通过键获取路径值
- (id)valueForKeyPath:(NSString *)keyPath;

*/

