//
//  NSObjectBlock.h
//  testBlock
//
//  Created by LvGuangDa on 2020/2/4.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(id anyID);;

@interface NSObjectBlock : NSObject

@property (nonatomic, copy) ClickBlock clickBlock;

/*
 * 初始化
 */
+ (instancetype)shareInstance;

- (void)timeCountParamater:(NSInteger )timeCount HandleBlock:(ClickBlock )handleBlock;



@end

