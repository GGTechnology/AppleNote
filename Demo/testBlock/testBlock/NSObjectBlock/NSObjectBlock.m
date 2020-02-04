//
//  NSObjectBlock.m
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "NSObjectBlock.h"

@implementation NSObjectBlock

/** 初始化 */
+ (instancetype)shareInstance {
    return [[self alloc]init];
}

- (void)timeCountParamater:(NSInteger )timeCount HandleBlock:(ClickBlock )handleBlock {
    // 第一步
    self.clickBlock = handleBlock;
    // 第二步
    if (self.clickBlock) {
        NSString *str = [NSString stringWithFormat:@"「NSObjectBlock.m」🍋 = %ld", timeCount];
        self.clickBlock(str);
    }
}

@end
