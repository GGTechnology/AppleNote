//
//  UIButton+LGDUIButtonExtension.h
//  防止UIButton连续重复点击
//
//  Created by LvGuangDa on 2020/2/6.
//  Copyright © 2020 shijunnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LGDUIButtonExtension)

// 按钮点击事件间隙响应时间
@property (nonatomic, assign) NSTimeInterval intervalClickTime;

@end

