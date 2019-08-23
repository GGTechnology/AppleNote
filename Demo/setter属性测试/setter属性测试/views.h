//
//  views.h
//  setter属性测试
//
//  Created by kadis on 2019/8/23.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface views : UIView

/*
 * 上面那个 setter 方式功能呢等同于下面那个 strong 属性
 * 用 setter 就会走 = 后面的方法
 * 用 strong 赋值自动就有 setter方法
 */

@property (nonatomic, setter=testArrayEvent:) NSArray *testArray;
@property (nonatomic, strong) NSDictionary *testDic;

@end

NS_ASSUME_NONNULL_END
