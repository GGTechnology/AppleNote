//
//  LGDAlertView.m
//  AlertView
//
//  Created by kadis on 2019/8/14.
//  Copyright © 2019 https://github.com/GGTechnology. All rights reserved.
//

#import "LGDAlertView.h"

@interface LGDAlertView () {
    dispatch_source_t timer; // 定时器
}
@property (nonatomic, copy)   ClickBlock leftButtonClickHandle;  // 取消按钮回调
@property (nonatomic, copy)   ClickBlock rightButtonClickHandle; // 取消按钮回调

@property (nonatomic, strong) UIViewController *nowVC;           // 当前VC
@property (nonatomic, strong) UIView *mainView;                  // 背景试图

@end

@implementation LGDAlertView

/// 初始化
+ (instancetype)shareInstance {
    return [[self alloc]init];
}

- (void)showAlertWithText:(id)text {
    self.nowVC = [LGDAlertView getCurrentVC];
    [self addShadowBackground];
    [self showAlertWithTextConfigurationView:text];
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        
        //设置模态格式：自定义模态格式
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        self.modalPresentationStyle = UIModalPresentationCustom;
        
        //设置转场动画
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        
        [self.nowVC presentViewController:self animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self closeView];
        });
    }
}
- (void)showAlertWithTextConfigurationView:(id )text {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.text = [NSString stringWithFormat:@"%@", text];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}

/*
 *
 * 带简单回调弹窗
 *
 */
- (void)showAlertWithBlock:(id)text
               leftHandle:(ClickBlock )leftBlock
              rightHandle:(ClickBlock) rightBlock {
    
    self.nowVC = [LGDAlertView getCurrentVC];
    [self addShadowBackground];
    self.leftButtonClickHandle = leftBlock;
    self.rightButtonClickHandle = rightBlock;
    [self showAlertWithBlockConfigurationView:text];
    
    if ([self.mainView isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.mainView];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.nowVC presentViewController:self animated:YES completion:nil];
    }
}
- (void)showAlertWithBlockConfigurationView:text {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.text = [NSString stringWithFormat:@"%@", text];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];

    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 100, 50)];
    leftButton.backgroundColor = [UIColor brownColor];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 50)];
    rightButton.backgroundColor = [UIColor purpleColor];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.tag = 10;
    [rightButton addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightButton];
}
/// 获取当前VC
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 取消按钮点击事件
- (void)cancelAction:(UIButton*)btn {
    if (self.leftButtonClickHandle) {
        self.leftButtonClickHandle(self);
    }
    [self closeView];
}

/// 确定按钮点击事件
- (void)okAction:(UIButton*)btn {
    if (btn.tag == 10) {
        if (self.rightButtonClickHandle) {
            self.rightButtonClickHandle(@"我传个参数 10 回去");
        }
    } else {
        if (self.rightButtonClickHandle) {
            self.rightButtonClickHandle(self);
        }
    }
    [self closeView];
}

/// 消失的处理
- (void)closeView {
    if (timer) {
        dispatch_source_cancel(timer);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 添加阴影背景
- (void)addShadowBackground {
    UIView *shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    shadowView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:shadowView];
    shadowView.alpha = 0.4f;
}

/// 背景
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _mainView;
}

@end
