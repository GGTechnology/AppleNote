//
//  ViewController.m
//  MasonryAnimation
//
//  Created by kadis on 2019/9/5.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#import "CHPlayerView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define MS [UIScreen mainScreen].bounds.size.width/2
#define VV self.view

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *red;
@property (nonatomic, strong) UIView *green;

@property (strong, nonatomic) CHPlayerView * playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@300);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    _green = [[UIView alloc] init];
    _green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_green];
    [_green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_red.mas_bottom).with.offset(100);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)aaa {
    [_red mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
//        make.centerX.equalTo(@0);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

@end
