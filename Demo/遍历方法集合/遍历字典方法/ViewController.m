//
//  ViewController.m
//  遍历字典方法
//
//  Created by kadis on 2020/3/4.
//  Copyright © 2020 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"action_%ld", (long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self action_0];
            break;
        case 1:
            [self action_1];
            break;
        case 2:
            [self action_2];
            break;
        case 3:
            [self action_3];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
}
// enumerateKeysAndObjectsUsingBlock 的使用，字典为例
- (void)action_0 {
    NSDictionary *dictM2 = @{@"1":@"one",@"2":@"two",@"3":@"three"};
    [dictM2 enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"🔴%@:%@",key,obj);
        
        // *stop 参数是停止遍历的意思
        
        // 使用方法1
        // 遍历字典，使 *stop = NO，或者直接不写即可遍历整个字典
        
        // 使用方法2
        // 遍历字典，当我们遍历到所需要的 key 停止遍历
        if ([key isEqualToString:@"2"]) {
            *stop = YES;
        }
    }];
}

// 基于 enumeratekeysandobjectsusingblock 遍历的综合使用（数组、字典、集合）
- (void)action_1 {
   // 遍历数组
   NSArray *arrayM = @[@"1",@"2",@"3",@"4"];
   [arrayM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       NSLog(@"🟠下标(idx) = %zd，🟠值(obj) = %@", idx, obj);
   }];
   
   // 遍历字典
   NSDictionary *dictM = @{@"1":@"one",@"2":@"two",@"3":@"three"};
   [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       NSLog(@"🟡key = %@, 🟡obj = %@",key, obj);
   }];
   
   // 遍历集合（集合是无序的）
   NSSet * setM = [[NSSet alloc] initWithObjects:@"one",@"two",@"three",@"four", nil];
   [setM enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
       NSLog(@"🟢%@",obj);
   }];
   
   // 反向遍历----降序遍历----以数组为例
   NSArray *arrayM2 = @[@"1",@"2",@"3",@"4"];
   [arrayM2 enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       NSLog(@"🔵下标(idx) = %zd，🔵值(obj) = %@",idx,obj);
   }];
}

// 基于 for....in 遍历的综合使用（数组、字典、集合）
- (void)action_2 {
    // 遍历数组
    NSArray *arrayM = @[@"1",@"2",@"3",@"4"];
    for (id obj in arrayM) {
        NSLog(@"💛%@", obj);
    }
    
    // 遍历字典
    NSDictionary *dictM = @{@"11":@"one",@"22":@"two",@"33":@"three"};
    for (id obj in dictM) {
        NSLog(@"💚key = %@, value = %@", obj, dictM[obj]);
    }
    
    // 遍历集合
    NSSet * setM = [[NSSet alloc] initWithObjects:@"one",@"two",@"three",@"four", nil];
    for (id obj in setM) {
        NSLog(@"💜%@",obj);
    }
    
    // 反向遍历----降序遍历----以数组为例
    NSArray *arrayM2 = @[@"1",@"2",@"3",@"4"];
    for (id obj in [arrayM2 reverseObjectEnumerator]) {
        NSLog(@"🧡%@",obj);
    }
}

// 基于 for循环 遍历的综合使用（数组、字典、集合）
- (void)action_3 {
    // 遍历处理数组
    NSArray *arrayM = @[@"11",@"22",@"33",@"44"];
    for (id obj in arrayM) {
        NSLog(@"🏀%@", obj);
    }
    
    // 遍历字典
    NSDictionary *dictM = @{@"11":@"one",@"22":@"two",@"33":@"three"};
    for (id obj in dictM) {
        NSLog(@"⚽️key = %@, value = %@", obj, dictM[obj]);
    }
    
    // 遍历理集合
    NSSet * setM = [[NSSet alloc] initWithObjects:@"one",@"two",@"three",@"four", nil];
    for (id obj in setM) {
        NSLog(@"🎾%@",obj);
    }
    
    // 反向遍历----降序遍历----以数组为例
    NSArray *arrayM2 = @[@"11",@"22",@"33",@"44"];
    for (id obj in [arrayM2 reverseObjectEnumerator]) {
        NSLog(@"🏐️%@",obj);
    }
}

@end
