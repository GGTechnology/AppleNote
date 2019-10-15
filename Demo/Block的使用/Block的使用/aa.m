//
//  aa.m
//  Block的使用
//
//  Created by kadis on 2019/10/10.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "aa.h"

@implementation aa

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
        btn1.backgroundColor = [UIColor greenColor];
        [btn1 addTarget:self action:@selector(a1) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
        btn2.backgroundColor = [UIColor yellowColor];
        [btn2 addTarget:self action:@selector(a2) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
    }
    return self;
}

- (void)a1 {
    NSLog(@"a1");
    if (self.block_a1) {
        self.block_a1(@"a1_view_button", @{@1:@1});
    }
}
- (void)a2 {
    NSLog(@"a2");
    if (self.block_a2) {
        self.block_a2(@"a2_view_button", @{@2:@2});
    }
}

@end
