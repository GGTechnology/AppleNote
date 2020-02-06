//
//  UIButton+LGDUIButtonExtension.m
//  防止UIButton连续重复点击
//
//  Created by LvGuangDa on 2020/2/6.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import "UIButton+LGDUIButtonExtension.h"
#import <objc/runtime.h>

static char * const intervalClickTimeKey = "intervalClickTimeKey";
static char * const canClickButtonKey = "canClickButtonKey";

@interface UIButton ()
// 是否可响应事件 YES:不会响应点击事件 NO:会响应点击事件
@property (nonatomic, assign) BOOL canClickButton;
@end

@implementation UIButton (LGDUIButtonExtension)

+ (void)load {
    // button 响应事件
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    // 自定义 button 响应点击事件
    Method lgd_method = class_getInstanceMethod(self, @selector(lgd_sendAction:to:forEvent:));
    // 交换方法
    method_exchangeImplementations(method, lgd_method);
}

#pragma -- mark Action
- (void)lgd_sendAction:(SEL )action to:(id )target forEvent:(UIEvent *)event {
    if (!self.canClickButton) {
        // 可以自定义默认间隔事件为 1 秒
        //  self.intervalClickTime = self.intervalClickTime == 0?3 : self.intervalClickTime;
        
        // 第一次执行点击事件后设置可以点击属性为 YES
        self.canClickButton = YES;
        [self lgd_sendAction:action to:target forEvent:event];
        
        // 延迟间隔事件设置是否可点击属性为 NO
        [self performSelector:@selector(setCanClickButton:) withObject:@(NO) afterDelay:self.intervalClickTime];
    }
}

#pragma -- mark getter & setter
- (NSTimeInterval)intervalClickTime {
    return [objc_getAssociatedObject(self, intervalClickTimeKey) doubleValue];
}
- (void)setIntervalClickTime:(NSTimeInterval)intervalClickTime {
    objc_setAssociatedObject(self, intervalClickTimeKey, @(intervalClickTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// runtime 添加按钮是否可点击
- (BOOL)canClickButton {
    return [objc_getAssociatedObject(self, canClickButtonKey) doubleValue];
}
- (void)setCanClickButton:(BOOL)canClickButton {
    objc_setAssociatedObject(self, canClickButtonKey, @(canClickButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
