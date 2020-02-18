//
//  aa.m
//  Block的使用
//
//  Created by kadis on 2019/10/10.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "aa.h"

@implementation aa

+ (instancetype)shareInstance {
    return [[self alloc] init];
}

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
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
        btn1.backgroundColor = [UIColor greenColor];
        [btn1 setTitle:@"a1" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(a1) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
        
        UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(150, 50, 50, 50)];
        btn5.backgroundColor = [UIColor whiteColor];
        [btn5 setTitle:@"a5" forState:UIControlStateNormal];
        [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn5 addTarget:self action:@selector(a5) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn5];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
        btn2.backgroundColor = [UIColor yellowColor];
        [btn2 setTitle:@"a2" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(a2) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 50, 50)];
        btn3.backgroundColor = [UIColor purpleColor];
        [btn3 setTitle:@"a3" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(a3) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn3];
        
        UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 350, 50, 50)];
        btn4.backgroundColor = [UIColor redColor];
        [btn4 setTitle:@"a4" forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(a4) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn4];
        
        if (self.blockHandel) {
            self.blockHandel(@"🍎");
        }
    }
    return self;
}
//-------------------------------------------------------
- (void)a1 {
    if (self.block_a1) {
        self.block_a1(@"a1_view_button", @{@1:@1});
    }
}
//-------------------------------------------------------
- (void)a2 {
    if (self.block_a2) {
        self.block_a2(@"a2_view_button", @{@2:@2});
    }
}
//-------------------------------------------------------
- (void)a3 {
    if (self.blockChange) {
        self.blockChange(@"🌹", nil);
    }
}
- (void)changeBackgroundColorr:(blockAA)blockChange {
    self.blockChange = blockChange;
}
//-------------------------------------------------------
- (void)a4 {
    // 不传参
//    if (self.blockName) {
//        self.blockName();
//    }
    
    // 穿参数
    if (self.blockBB) {
        self.blockBB(@"a4");
    }
    
}
//-------------------------------------------------------
- (void)a5 {
    if (self.tempBlockBB) {
        self.tempBlockBB(@"🚗");
    } else {
        NSLog(@"👛👛👛");
    }
}
- (void)blue:(blockBB)blockCC parameter:(NSString *)string {
    NSLog(@"%@", string);
    self.tempBlockBB = blockCC;
}
//-------------------------------------------------------

- (NSString *)ButtonWithTitle:(NSString *)title BlockWithAction:(ClickBlock )action {
//    if (self.blockHandel) {
//        self.blockHandel = action;
//        return title;
//    } else {
//        return @"No_Connected";
//    }
//
    self.blockHandel = action;
    return title;
}

@end
