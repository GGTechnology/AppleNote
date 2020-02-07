//
//  ViewController.m
//  KVO简单实现
//
//  Created by LvGuangDa on 2019/10/21.
//  Copyright © 2019 shijunnian. All rights reserved.
//

#import "ViewController.h"
#import "KVC_VC.h"


@interface Person : NSObject
@property(nonatomic,copy)NSString *name;
@end
@implementation Person
@end

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ZiBianLiang;
@property (weak, nonatomic) IBOutlet UILabel *YinBianLiang;
@property (nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _YinBianLiang.numberOfLines = 0;
    _ZiBianLiang.numberOfLines = 0;
    
    Person *p = [[Person alloc]init];
    //引用
    _p = p;
    // 注册，指定被观察者属性
    // keyPath就是要观察的属性值
    // options给你观察键值变化的选择
    // 而context方便传输你需要的数据（注意这是一个void型）
    [_p addObserver:self
         forKeyPath:@"name"
            options:(NSKeyValueObservingOptionNew)
            context:nil];
}

- (IBAction)ButtonClickChangeValue {
    static int a = 10;
    _p.name = [NSString stringWithFormat:@"%d",a++];
    
    _ZiBianLiang.text = [NSString stringWithFormat:@"自变量 _p.name = %@", _p.name];
}

// 回调方法
// change里存储了一些变化的数据，比如变化前的数据，变化后的数据；
// 如果注册时context不为空，这里context就能接收到。传递“空”用NULL而不是nil
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    //观察者观察name的变化,当点击屏幕,改变name的值,chang就会捕获新值.
    NSLog(@"%@",change);
    
    _YinBianLiang.text = [NSString stringWithFormat:@"因变量 change = %@", change];
}

// 移除观察
//- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;










- (IBAction)Present_KVC_ViewController {
    KVC_VC *vc = [KVC_VC new];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
