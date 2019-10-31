//
//  ViewController.m
//  Block的使用
//
//  Created by kadis on 2019/8/21.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import "aa.h"

@interface ViewController ()
@property (nonatomic, strong) aa *cc;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cc = [[aa alloc] initWithFrame:CGRectMake(10, 100, 250, 450)];
    _cc.backgroundColor = [UIColor brownColor];
//------------------------ a1 -------------------------------
    [self.view addSubview:_cc];
    [_cc setBlock_a1:^(NSString *str, NSDictionary *dic) {
        NSLog(@"🍎%@🌞%@🍎", str, dic);
        self->_cc.backgroundColor = [UIColor cyanColor];
    }];
//------------------------ a2 -------------------------------
    [_cc setBlock_a2:^(NSString *str, NSDictionary *dic) {
        NSLog(@"🍍%@❄️%@🍍", str, dic);
        self->_cc.backgroundColor = [UIColor orangeColor];
    }];
//------------------------ a3 -------------------------------
    [_cc changeBackgroundColorr:^(NSString *str, NSDictionary *dic) {
        NSLog(@"%@, %@", str, dic);
        _cc.backgroundColor = [UIColor blackColor];
    }];
//------------------------ a4 -------------------------------
    [_cc setBlockName:^{
        NSLog(@"🍏blockName🍏");
        _cc.backgroundColor = [UIColor brownColor];
    }];
//------------------------ a5 -------------------------------
    [_cc blue:^(NSString *str) {
        _cc.backgroundColor = [UIColor grayColor];
        NSLog(@"%@", str);
    }];
//-------------------------------------------------------
    
    /*
     *  有参数
     */
    // --- 直接写 ---
    NSString *(^blockTest)(NSString *, int) = ^(NSString *num, int count){
        return [NSString stringWithFormat:@"%d", [num intValue] * count];
    };
    NSLog(@"%@", blockTest(@"8", 11));
    
    // --- 分开写 ---
    NSString * (^myBolock)(int);
    myBolock = ^(int parameta){
        return [NSString stringWithFormat:@"%d", parameta];
    };
    NSLog(@"%@", myBolock(0000));
    //-------------------------------------- 分割线 --------------------------------------
    int (^vv)(int) = ^(int paramate) {
        return paramate;
    };
    int a = vv(999999);
    NSLog(@"%d", a);
    
    /*
    *  无参数
    */
    void (^gg)(void) = ^(void){
         NSLog(@"😄");
    };
    gg();
}
- (IBAction)a6:(id)sender {
    [[aa shareInstance] blue:^(NSString *str) {
       NSLog(@"%@", str);
    }];
}

@end
