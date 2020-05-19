//
//  NoTypedefViewBlock.m
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "NoTypedefViewBlock.h"

@implementation NoTypedefViewBlock

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor magentaColor];
        [self addTarget:self action:@selector(TimeCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)TimeCount:(void (^) (void))timeBlock {
    if (timeBlock) {
        timeBlock();
    }
}

@end
