//
//  ButtonBlock.m
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "ButtonBlock.h"

@implementation ButtonBlock

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

        self.backgroundColor = [UIColor clearColor];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, i*115, 200, 100)];
            [btn.layer setCornerRadius:50];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:btn];
            switch (i) {
                case 0:
                {
                    btn.backgroundColor = [UIColor brownColor];
                    [btn setTitle:@"firstBlockAction" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(firstBlockAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 1:
                {
                    btn.backgroundColor = [UIColor orangeColor];
                    [btn setTitle:@"secondBlockAction" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(secondBlockAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                default:
                {
                    btn.backgroundColor = [UIColor grayColor];
                    [btn setTitle:@"thirdBlockAction" forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(thirdBlockAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
            }
        }
    }
    return self;
}

//
// 形式一:无传参，无返回值
//
- (void)firstBlockAction:(UIButton *)btn {
    if (self.firstBlock) {
        self.firstBlock();
    }
}

//
// 形式二:无传参，有返回值(id)
//
- (void)secondBlockAction:(UIButton *)btn {
    if (self.secondBlock) {
        self.secondBlock(@"「ButtonBlock.m」🍑");
    }
}

//
// 形式三:有传参(NSString)，有返回值(NSString)
//
- (void)thirdBlockAction:(UIButton *)btn {
    NSString * tempStr;
    if (self.thirdBlock) {
        tempStr = self.thirdBlock(@"「ButtonBlock.m」🍓");
        NSLog(@"\ntempStr = %@",tempStr);
    }
}

@end
